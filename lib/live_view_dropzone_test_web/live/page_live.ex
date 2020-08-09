defmodule LiveViewDropzoneTestWeb.PageLive do
  use LiveViewDropzoneTestWeb, :live_view

  alias LiveViewDropzoneTest.Uploads

  def mount(_params, _session, socket) do
    {:ok, assign(socket, query: "", results: %{}, file_data: %{})}
  end

  def handle_event("phx-dropzone", ["generate-url", %{"id" => id, "name" => file_name}], socket) do
    {:ok, signed_url} = Uploads.get_signed_url(file_name)
    {:noreply, assign(socket, file_data: %{id: id, url: signed_url})}
  end

  def handle_event(
        "phx-dropzone",
        ["file-status", %{"status" => "InProgress", "progress" => progress}],
        socket
      ) do
    {:noreply, assign(socket, status: :uploading, progress: progress)}
  end

  def handle_event(
        "phx-dropzone",
        ["file-status", %{"status" => "Done", "name" => file_name}],
        socket
      ) do
    {:ok, video_url} = Uploads.get_download_url(file_name)
    {:noreply, assign(socket, status: :success, video_url: video_url)}
  end

  def handle_event("phx-dropzone", ["file-status", _payload], socket) do
    {:noreply, assign(socket, status: :error)}
  end
end
