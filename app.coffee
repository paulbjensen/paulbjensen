express = require 'express'
assets  = require 'connect-assets'

app     = express.createServer express.logger()

app.use assets buildDir: "builtAssets"
app.use express.static "#{__dirname}/public"
app.set 'view engine', 'jade'


app.get '/', (req, res) ->
  res.render 'layout'

app.listen 3000