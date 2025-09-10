# app.jl - Adaptación de app.py a Julia
using Genie, Genie.Renderer.Html
include("api.jl")

Genie.config.run_as_server = true
Genie.config.server_host = "0.0.0.0"
Genie.config.server_port = 5000

route("/") do
    status = get_status()
    html(render("index.html", status=status))
end

up()
