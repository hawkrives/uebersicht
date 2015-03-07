fs     = require 'fs'
coffee = require 'coffee-script'
babel  = require('babel-core/register')({extensions: ['.es']})

# throws error if something goes wrong
exports.loadWidget = loadWidget = (filePath) ->
  definition = fs.readFileSync(filePath, encoding: 'utf8')

  if filePath.match /\.coffee$/
    definition = coffee.eval definition
  else if filePath.match /\.es$/
    delete require.cache[require.resolve filePath]
    definition = require filePath
  else
    definition = eval '({' + definition + '})'

  definition.filePath = filePath
  definition
