-- Create the trips table
create table public.trips (
  id uuid default gen_random_uuid() primary key,
  user_id uuid references auth.users(id) on delete cascade,
  name text,
  start_date date,
  end_date date,
  season text,
  is_specific_dates boolean default true,
  budget_per_night numeric,
  
  -- Location details
  continent text,
  country text,
  state text,
  city text,
  
  -- Lodging preferences
  cleanliness_level numeric,
  cleanliness_importance numeric,
  noise_level numeric,
  noise_importance numeric,
  
  -- Travel style
  itinerary_style numeric,
  itinerary_importance numeric,
  early_riser_style numeric,
  early_riser_importance numeric,
  alone_time_style numeric,
  alone_time_importance numeric,
  
  -- Social preferences
  activity_together_style numeric,
  activity_together_importance numeric,
  sharing_items_style numeric,
  sharing_items_importance numeric,
  
  -- Personal details
  pronouns text,
  sexual_orientation text,
  astrological_sign text,
  
  -- Arrays for interests and dynamics
  interests text[] default '{}',
  group_dynamic text,
  
  -- Contact Information
  contact_email text,
  contact_phone text,
  host_name text,
  host_image_url text,
  
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- Enable Row Level Security (RLS)
alter table public.trips enable row level security;

-- Create policy to allow users to insert their own trips
create policy "Users can insert their own trips" 
on public.trips for insert 
with check (auth.uid() = user_id);

-- Create policy to allow users to view their own trips
create policy "Users can view their own trips" 
on public.trips for select 
using (auth.uid() = user_id);

-- Create policy to allow users to update their own trips
create policy "Users can update their own trips" 
on public.trips for update 
using (auth.uid() = user_id);

-- Create policy to allow users to delete their own trips
create policy "Users can delete their own trips" 
on public.trips for delete 
using (auth.uid() = user_id);
