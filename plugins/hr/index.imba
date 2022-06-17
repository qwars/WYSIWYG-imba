
const ISymbol = require './symbol.svg'

export tag Plugin < kbd

	def commandExec
		data.execCommand 'styleWithCSS', true
		data.execCommand 'insertHorizontalRule', false
		data.execCommand 'styleWithCSS', false
		data:body.focus

	def render
		<self :tap.commandExec> <svg:svg> <svg:use href="{ ISymbol }#symbol">
