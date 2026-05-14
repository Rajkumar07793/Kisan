-- Kisan Seva: Tractors and Bookings Schema
-- This file contains the table definitions, RLS policies, and demo data for tractor listings and bookings.

-- 1. Tractors Table
-- Stores information about tractors available for hire.
CREATE TABLE IF NOT EXISTS public.tractors (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    owner_id UUID REFERENCES public.users(id) ON DELETE CASCADE NOT NULL,
    model TEXT NOT NULL, -- e.g., 'Mahindra 575 DI'
    hp TEXT NOT NULL, -- e.g., '47 HP'
    services TEXT[] DEFAULT '{}', -- Array of service IDs: ['jutai', 'harvesting', 'rotavator']
    village TEXT NOT NULL,
    city TEXT NOT NULL,
    district TEXT NOT NULL,
    state TEXT NOT NULL,
    rating NUMERIC(3,2) DEFAULT 0.0,
    reviews INTEGER DEFAULT 0,
    available BOOLEAN DEFAULT TRUE,
    price TEXT NOT NULL, -- e.g., '800/hr'
    image TEXT DEFAULT '🚜', -- Emoji or storage URL
    is_verified BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. Bookings Table
-- Stores rental requests from Kisans to Tractor Owners.
CREATE TABLE IF NOT EXISTS public.bookings (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    kisan_id UUID REFERENCES public.users(id) ON DELETE CASCADE NOT NULL,
    tractor_id UUID REFERENCES public.tractors(id) ON DELETE CASCADE NOT NULL,
    booking_date TIMESTAMP WITH TIME ZONE NOT NULL,
    service_type TEXT NOT NULL, -- Matches an ID from the tractor's services array
    booking_status TEXT DEFAULT 'pending', -- 'pending', 'accepted', 'completed', 'cancelled'
    acreage NUMERIC(10,2), -- Estimated area to be worked
    total_cost NUMERIC(10,2), -- Calculated based on price and acreage/time
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 3. Enable Row Level Security (RLS)
ALTER TABLE public.tractors ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.bookings ENABLE ROW LEVEL SECURITY;

-- 4. Tractors Policies
-- Anyone can view tractor listings
CREATE POLICY "Public can view tractors" 
ON public.tractors FOR SELECT 
USING (true);

-- Owners can manage (Insert, Update, Delete) their own tractor listings
CREATE POLICY "Owners can manage own tractors" 
ON public.tractors 
FOR ALL TO authenticated 
USING (auth.uid() = owner_id)
WITH CHECK (auth.uid() = owner_id);

-- 5. Bookings Policies
-- Users can view bookings they are involved in (either as the Kisan who booked or the Tractor Owner)
CREATE POLICY "Users can view involved bookings" 
ON public.bookings 
FOR SELECT TO authenticated 
USING (
    auth.uid() = kisan_id OR 
    auth.uid() IN (SELECT owner_id FROM public.tractors WHERE id = tractor_id)
);

-- Kisans can create bookings
CREATE POLICY "Kisans can insert bookings" 
ON public.bookings 
FOR INSERT TO authenticated 
WITH CHECK (auth.uid() = kisan_id);

-- Both parties can update status (e.g., Kisan cancelling or Owner accepting)
CREATE POLICY "Involved parties can update bookings" 
ON public.bookings 
FOR UPDATE TO authenticated 
USING (
    auth.uid() = kisan_id OR 
    auth.uid() IN (SELECT owner_id FROM public.tractors WHERE id = tractor_id)
);

-- 6. Performance Indexes
CREATE INDEX IF NOT EXISTS idx_tractors_owner_id ON public.tractors(owner_id);
CREATE INDEX IF NOT EXISTS idx_tractors_available ON public.tractors(available);
CREATE INDEX IF NOT EXISTS idx_bookings_kisan_id ON public.bookings(kisan_id);
CREATE INDEX IF NOT EXISTS idx_bookings_tractor_id ON public.bookings(tractor_id);
CREATE INDEX IF NOT EXISTS idx_bookings_status ON public.bookings(booking_status);

-- 7. Realistic Demo Data
-- IMPORTANT: Replace 'USER_ID_1' and 'USER_ID_2' with valid UUIDs from your 'public.users' table to test RLS.

/*
-- DEMO DATA INSERTION (Uncomment and replace IDs to use)

INSERT INTO public.tractors (owner_id, model, hp, services, village, city, district, state, rating, reviews, price, image, is_verified)
VALUES 
('REPLACE_WITH_REAL_UUID', 'Mahindra 575 DI', '47 HP', '{"jutai", "harvesting", "rotavator"}', 'सेमरिया', 'जबलpur', 'जबलपुर', 'मध्य प्रदेश', 4.8, 34, '800/घंटा', '🚜', true),
('REPLACE_WITH_REAL_UUID', 'John Deere 5050 D', '50 HP', '{"ganna", "transport", "harvesting"}', 'पाटन', 'जबलपुर', 'जबलपुर', 'मध्य प्रदेश', 4.5, 21, '1000/घंटा', '🚜', true),
('REPLACE_WITH_REAL_UUID', 'Swaraj 855 FE', '55 HP', '{"jutai", "sowing", "threshing", "laser_leveling"}', 'बरेला', 'नरसिंहपुर', 'नरसिंहपुर', 'मध्य प्रदेश', 4.2, 15, '900/घंटा', '🚜', false);

INSERT INTO public.bookings (kisan_id, tractor_id, booking_date, service_type, booking_status, acreage, total_cost)
VALUES 
('REPLACE_WITH_KISAN_UUID', (SELECT id FROM public.tractors LIMIT 1), NOW() + INTERVAL '2 days', 'jutai', 'pending', 5.0, 4000.0);
*/
