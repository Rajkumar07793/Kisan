-- HerStay Supabase Database Schema
-- Last Updated: 2026-05-05

-- 1. Create the 'users' table in the public schema
-- This table stores extended profile information linked to Supabase Auth
CREATE TABLE IF NOT EXISTS public.users (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    phone TEXT UNIQUE,
    phone_code TEXT,
    country_code TEXT,
    role TEXT DEFAULT 'user',
    profile_image TEXT,
    dob TIMESTAMP WITH TIME ZONE,
    status INTEGER DEFAULT 1, -- 1: Active, 0: Inactive
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION,
    address TEXT,
    is_blocked BOOLEAN DEFAULT FALSE,
    user_type INTEGER DEFAULT 0, -- 0: Customer, 1: Provider
    device_tokens TEXT[] DEFAULT '{}', -- Array of notification tokens (FCM/APNs)
    password TEXT, -- Local reference (Auth.users handles secure hashing)
    inspirations TEXT[] DEFAULT '{}', -- List of what inspires the user
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. Enable Row Level Security (RLS)
-- This is critical for preventing unauthorized access to user data
ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;

-- 3. Row Level Security Policies
-- Policy: Users can view their own profile
CREATE POLICY "Users can view own profile" 
ON public.users 
FOR SELECT 
TO authenticated 
USING (auth.uid() = id);

-- Policy: Users can update their own profile
CREATE POLICY "Users can update own profile" 
ON public.users 
FOR UPDATE 
TO authenticated 
USING (auth.uid() = id)
WITH CHECK (auth.uid() = id);

-- Policy: Users can insert their own profile during signup
CREATE POLICY "Users can insert own profile" 
ON public.users 
FOR INSERT 
TO authenticated 
WITH CHECK (auth.uid() = id);

-- Policy: Allow anyone (even unauthenticated) to check if a phone exists
-- This is needed for the pre-signup check in the app
CREATE POLICY "Allow public phone check" 
ON public.users 
FOR SELECT 
TO anon, authenticated
USING (true); 

-- 4. Automatic Profile Creation Trigger
-- This function runs whenever a new user is created in auth.users
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.users (
    id, email, name, phone, phone_code, country_code, password, inspirations
  )
  VALUES (
    NEW.id, 
    NEW.email, 
    COALESCE(NEW.raw_user_meta_data->>'name', ''),
    COALESCE(NEW.raw_user_meta_data->>'phone', ''),
    COALESCE(NEW.raw_user_meta_data->>'phone_code', ''),
    COALESCE(NEW.raw_user_meta_data->>'country_code', ''),
    COALESCE(NEW.raw_user_meta_data->>'password', ''),
    COALESCE(ARRAY(SELECT jsonb_array_elements_text(NEW.raw_user_meta_data->'inspirations')), '{}')
  )
  ON CONFLICT (id) DO UPDATE SET
    email = EXCLUDED.email,
    name = EXCLUDED.name,
    phone = EXCLUDED.phone,
    phone_code = EXCLUDED.phone_code,
    country_code = EXCLUDED.country_code,
    password = EXCLUDED.password,
    inspirations = EXCLUDED.inspirations;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger that calls the function after a row is inserted into auth.users
CREATE OR REPLACE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE PROCEDURE public.handle_new_user();

-- 5. Automatic 'updated_at' Management
-- Function to update the updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Trigger to execute the function before any update on the users table
CREATE TRIGGER update_users_updated_at
    BEFORE UPDATE ON public.users
    FOR EACH ROW
    EXECUTE PROCEDURE update_updated_at_column();

-- 6. Performance Indexes
CREATE INDEX IF NOT EXISTS idx_users_email ON public.users(email);
CREATE INDEX IF NOT EXISTS idx_users_role ON public.users(role);
CREATE INDEX IF NOT EXISTS idx_users_user_type ON public.users(user_type);

-- 6. Storage Bucket Configuration (Optional Recommendation)
-- If you use profile images, ensure you have a 'profiles' bucket in Supabase Storage
-- and appropriate policies to allow users to upload their own images.
-- 1. Tractors Table
CREATE TABLE IF NOT EXISTS public.tractors (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    owner_id UUID REFERENCES public.users(id) ON DELETE CASCADE NOT NULL,
    model TEXT NOT NULL,
    hp TEXT NOT NULL,
    services TEXT[] DEFAULT '{}',
    village TEXT NOT NULL,
    city TEXT NOT NULL,
    district TEXT NOT NULL,
    state TEXT NOT NULL,
    rating NUMERIC(3,2) DEFAULT 0.0,
    reviews INTEGER DEFAULT 0,
    available BOOLEAN DEFAULT TRUE,
    price TEXT NOT NULL,
    image TEXT DEFAULT '🚜',
    is_verified BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. Bookings Table
CREATE TABLE IF NOT EXISTS public.bookings (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    kisan_id UUID REFERENCES public.users(id) ON DELETE CASCADE NOT NULL,
    tractor_id UUID REFERENCES public.tractors(id) ON DELETE CASCADE NOT NULL,
    booking_date TIMESTAMP WITH TIME ZONE NOT NULL,
    service_type TEXT NOT NULL,
    booking_status TEXT DEFAULT 'pending', -- pending, accepted, completed, cancelled
    acreage NUMERIC(10,2),
    total_cost NUMERIC(10,2),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 3. Enable RLS
ALTER TABLE public.tractors ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.bookings ENABLE ROW LEVEL SECURITY;

-- 4. Tractors Policies
CREATE POLICY "Anyone can view tractors" ON public.tractors FOR SELECT USING (true);
CREATE POLICY "Owners can manage their own tractors" ON public.tractors 
    FOR ALL TO authenticated USING (auth.uid() = owner_id);

-- 5. Bookings Policies
CREATE POLICY "Users can view their own bookings" ON public.bookings 
    FOR SELECT TO authenticated USING (
        auth.uid() = kisan_id OR 
        auth.uid() IN (SELECT owner_id FROM public.tractors WHERE id = tractor_id)
    );
CREATE POLICY "Kisans can create bookings" ON public.bookings 
    FOR INSERT TO authenticated WITH CHECK (auth.uid() = kisan_id);
CREATE POLICY "Owners and Kisans can update their bookings" ON public.bookings 
    FOR UPDATE TO authenticated USING (
        auth.uid() = kisan_id OR 
        auth.uid() IN (SELECT owner_id FROM public.tractors WHERE id = tractor_id)
    );

-- 6. Updated At Triggers
CREATE TRIGGER update_tractors_updated_at BEFORE UPDATE ON public.tractors
    FOR EACH ROW EXECUTE PROCEDURE update_updated_at_column();

CREATE TRIGGER update_bookings_updated_at BEFORE UPDATE ON public.bookings
    FOR EACH ROW EXECUTE PROCEDURE update_updated_at_column();

-- 7. Realistic Demo Data
-- Note: Replace UUIDs with actual user IDs from your auth.users table for testing.
-- For now, we use placeholders or assuming some users exist.

-- Insert some tractors
INSERT INTO public.tractors (owner_id, model, hp, services, village, city, district, state, rating, reviews, price, image, is_verified)
VALUES 
('d1234567-89ab-cdef-0123-456789abcdef', 'Mahindra 575 DI', '47 HP', '{"jutai", "harvesting", "rotavator"}', 'Semariya', 'Jabalpur', 'Jabalpur', 'Madhya Pradesh', 4.8, 34, '800/hr', '🚜', true),
('d1234567-89ab-cdef-0123-456789abcdef', 'John Deere 5050 D', '50 HP', '{"ganna", "transport", "harvesting"}', 'Patan', 'Jabalpur', 'Jabalpur', 'Madhya Pradesh', 4.5, 21, '1000/hr', '🚜', true),
('e2345678-90bc-def0-1234-567890abcdef', 'Swaraj 855 FE', '55 HP', '{"jutai", "sowing", "threshing", "laser_leveling"}', 'Barela', 'Narsinghpur', 'Narsinghpur', 'Madhya Pradesh', 4.2, 15, '900/hr', '🚜', false);
