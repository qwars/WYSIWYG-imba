
const ISymbol = require './symbol.svg'

export tag Plugin < kbd

	def commandExec
		if data.getSelection:anchorNode:parentElement:style:textDecorationLine.includes 'overline' then console.log data.getSelection:anchorNode:parentElement:style:textDecorationLine = data.getSelection:anchorNode:parentElement:style:textDecorationLine.replace /\s*overline\s*/, ''
		else
			data.execCommand 'styleWithCSS', true
			data.execCommand 'fontName', false, 'editor-state'
			data.execCommand 'styleWithCSS', false
			Array.from data.querySelectorAll( '[style*="editor-state"]' ), do |item|
				item:style:fontFamily = null
				item:style:textDecorationLine += ' overline'

	def render
		<self :tap.commandExec> <svg:svg> <svg:use href="{ ISymbol }#symbol">
