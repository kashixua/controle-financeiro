-- Controle Financeiro • complemento de segurança e integração Web
-- Execute uma vez no SQL Editor do Supabase.

-- O caixa atual faz parte das configurações individuais do usuário.
alter table public.configuracoes
  add column if not exists caixa_atual numeric(12,2) not null default 0;

-- Permissões mínimas para o cliente autenticado.
grant usage on schema public to authenticated;
grant select, insert, update, delete on table
  public.profiles,
  public.receitas,
  public.despesas,
  public.dividas,
  public.pagamentos,
  public.uber,
  public.shows,
  public.reservas,
  public.fechamentos,
  public.configuracoes
  to authenticated;

-- A chave pública não recebe acesso direto aos dados financeiros.
revoke all on table
  public.profiles,
  public.receitas,
  public.despesas,
  public.dividas,
  public.pagamentos,
  public.uber,
  public.shows,
  public.reservas,
  public.fechamentos,
  public.configuracoes
  from anon;

-- Garante RLS em todas as tabelas financeiras.
alter table public.profiles enable row level security;
alter table public.receitas enable row level security;
alter table public.despesas enable row level security;
alter table public.dividas enable row level security;
alter table public.pagamentos enable row level security;
alter table public.uber enable row level security;
alter table public.shows enable row level security;
alter table public.reservas enable row level security;
alter table public.fechamentos enable row level security;
alter table public.configuracoes enable row level security;
