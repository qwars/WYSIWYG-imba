
const ISymbol = require './symbol.svg'

export tag Plugin < span

	def commandExec
		data.execCommand $1, false

	def render
		<self.buttons>
			<kbd :tap.commandExec('insertUnorderedList')> <svg:svg> <svg:use href="{ ISymbol }#list-ul">
			<kbd :tap.commandExec('insertOrderedList')> <svg:svg> <svg:use href="{ ISymbol }#list-ol">

