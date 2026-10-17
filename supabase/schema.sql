-- NexoPol · Base de datos para foro comunitario compartido
-- Ejecutar en Supabase > SQL Editor. Activar Auth > Anonymous Sign-Ins.
-- El nombre, departamento, municipio, comunidad y publicación serán visibles para los participantes del foro.
create extension if not exists pgcrypto;
create table if not exists public.nexopol_posts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  author_name text not null check (char_length(author_name) between 1 and 70),
  department text not null check (char_length(department) between 2 and 100),
  municipality text not null check (char_length(municipality) between 1 and 100),
  community text not null check (char_length(community) between 1 and 100),
  category text not null check (category in ('Experiencia','Pregunta','Idea','Alerta')),
  title text not null check (char_length(title) between 5 and 100),
  body text not null check (char_length(body) between 10 and 1500),
  created_at timestamptz not null default now()
);
create index if not exists nexopol_posts_created_idx on public.nexopol_posts(created_at desc);
create table if not exists public.nexopol_comments (
  id uuid primary key default gen_random_uuid(),
  post_id uuid not null references public.nexopol_posts(id) on delete cascade,
  user_id uuid not null references auth.users(id) on delete cascade,
  author_name text not null check (char_length(author_name) between 1 and 70),
  body text not null check (char_length(body) between 3 and 450),
  created_at timestamptz not null default now()
);
create index if not exists nexopol_comments_post_idx on public.nexopol_comments(post_id,created_at);
alter table public.nexopol_posts enable row level security;
alter table public.nexopol_comments enable row level security;
revoke all on public.nexopol_posts, public.nexopol_comments from PUBLIC, anon, authenticated;
grant select, insert, delete on public.nexopol_posts, public.nexopol_comments to authenticated;
-- Los participantes autenticados (incluye inicio de sesión anónimo) pueden leer el foro.
create policy "NexoPol posts public to signed-in" on public.nexopol_posts for select to authenticated using (true);
create policy "NexoPol posts author creates" on public.nexopol_posts for insert to authenticated with check ((select auth.uid()) = user_id);
create policy "NexoPol posts author deletes" on public.nexopol_posts for delete to authenticated using ((select auth.uid()) = user_id);
create policy "NexoPol comments public to signed-in" on public.nexopol_comments for select to authenticated using (true);
create policy "NexoPol comments author creates" on public.nexopol_comments for insert to authenticated with check ((select auth.uid()) = user_id);
create policy "NexoPol comments author deletes" on public.nexopol_comments for delete to authenticated using ((select auth.uid()) = user_id);
-- Para un despliegue público real, incorporar moderación, reporte de abuso y limitación de frecuencia.
