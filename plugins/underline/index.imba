
const ISymbol = require './symbol.svg'

export tag Plugin < kbd

	def commandExec
		data.execCommand 'styleWithCSS', true
		data.execCommand 'underline', false
		data.execCommand 'styleWithCSS', false

	def render
		<self :tap.commandExec> <svg:svg> <svg:use href="{ ISymbol }#symbol">
