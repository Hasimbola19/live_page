defmodule ProjetWeb.Live.ContactLive do
  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    quantite = 0
    prix_unitaire = 0
    prix_total = 0
    {:ok,
      socket |> assign(quantite: quantite, prix_total: prix_total, prix_unitaire: prix_unitaire) ,layout: {ProjetWeb.LayoutView, "live.html"}
    }
  end

  def handle_info({:live_session_updated, session}, socket) do
    {:noreply, put_session_assigns(socket, session)}
  end

  defp put_session_assigns(socket, session) do
    socket
    |> assign(
      shopping_cart: Map.get(session, "shopping_cart", []),
      quantite: Map.get(session, "quantite", 0)
    )
  end

  def render(assigns) do
    ProjetWeb.PageView.render("contact.html", assigns)
  end
end
