
const ISymbol = require './symbol.svg'

export tag Plugin < span

	def commandExec
		data.execCommand $1, false

	def render
		<self.buttons>
			<kbd :tap.commandExec('justifyLeft')> <svg:svg> <svg:use href="{ ISymbol }#align-left">
			<kbd :tap.commandExec('justifyCenter')> <svg:svg> <svg:use href="{ ISymbol }#align-center">
			<kbd :tap.commandExec('justifyFull')> <svg:svg> <svg:use href="{ ISymbol }#align-justify">
			<kbd :tap.commandExec('justifyRight')> <svg:svg> <svg:use href="{ ISymbol }#align-right">
