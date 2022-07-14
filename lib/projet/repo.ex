defmodule Projet.Repo do
  use Ecto.Repo,
    otp_app: :projet,
    adapter: Ecto.Adapters.Postgres
end
