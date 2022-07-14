defmodule ProjetWeb.Live.IndexLive do
  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    quantite = 0
    prix_unitaire = 0
    prix_total = 0
    {:ok,
      socket |> assign(quantite: quantite, prix_total: prix_total, prix_unitaire: prix_unitaire) ,layout: {ProjetWeb.LayoutView, "live.html"}
    }
  end

  def render(assigns) do
    ProjetWeb.PageView.render("index.html", assigns)
  end
end
