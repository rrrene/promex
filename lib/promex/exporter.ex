defmodule Promex.Exporter do
  use Plug.Router
  require Logger

  plug :match
  plug :dispatch

  def init(opts), do: opts

  def start_link do
    Plug.Adapters.Cowboy.http(
      Promex.Exporter,
      [],
      [port: Application.get_env(:promex, :port)]
    )
  end

  get "/metrics" do
    conn
    |> send_resp(200, parsed_metrics(Promex.Collector.metrics))
    |> halt
  end

  get "/favicon.ico" do
    conn
    |> send_resp(404, "Not Found")
    |> halt
  end

  defp parsed_metrics(metrics) do
    Enum.map(metrics, &parse_metric/1)
  end

  defp parse_metric(metric) do
    metric = Tuple.to_list(metric)
    "#{List.first(metric)} #{List.last(metric)}\n"
  end
end
