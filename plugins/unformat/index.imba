
const ISymbol = require './symbol.svg'

export tag Plugin < kbd

	def commandExec
		data.execCommand 'removeFormat', false

	def render
		<self :tap.commandExec> <svg:svg> <svg:use href="{ ISymbol }#symbol">
