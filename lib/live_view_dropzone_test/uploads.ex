defmodule LiveViewDropzoneTest.Uploads do
  def get_signed_url(file_name) do
    ExAws.S3.presigned_url(config(), :put, bucket(), path(file_name),
      query_params: [],
      virtual_host: true
    )
  end

  def get_download_url(file_name) do
    ExAws.S3.presigned_url(config(), :get, bucket(), path(file_name),
      query_params: [],
      virtual_host: true
    )
  end

  def check_if_exists(_file_name) do
    # use ExAws.S3.head_object for this
    # Idea: if exists, ask for upload anyway, change name then
  end

  defp path(file_name) do
    "testing/ranger/#{file_name}"
  end

  defp bucket do
    Application.get_env(:ex_aws, :bucket)
  end

  defp config do
    ExAws.Config.new(:s3)
    |> Map.put(:region, region())
  end

  defp region do
    Application.get_env(:ex_aws, :region)
  end
end
