defmodule ProjetWeb.PageController do
  use ProjetWeb, :controller
  alias Phoenix.LiveView

  def index(conn, _params) do
    # render(conn, "index.html")
    LiveView.Controller.live_render(conn, ProjetWeb.Live.IndexLive)
  end

  def produit(conn, _params) do
    LiveView.Controller.live_render(conn, ProjetWeb.Live.ProduitLive)
  end

  def contact(conn, _params) do
    LiveView.Controller.live_render(conn, ProjetWeb.Live.ContactLive)
  end

  def compte(conn, _params) do
    LiveView.Controller.live_render(conn, ProjetWeb.Live.CompteLive)
  end

  def inscription(conn, _params) do
    LiveView.Controller.live_render(conn, ProjetWeb.Live.InscriptionLive)
  end

  def connexion(conn, _params) do
    LiveView.Controller.live_render(conn, ProjetWeb.Live.ConnexionLive)
  end

  def search(conn, _params) do
    Plug.Conn.get_session(conn, "quantite")
    IO.puts "session"
    IO.inspect Plug.Conn.get_session(conn, "quantite")
    LiveView.Controller.live_render(conn, ProjetWeb.Live.ProduitLive)
  end

end
