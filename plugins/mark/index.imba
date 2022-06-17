
import Widget as ColorsCollection from '../../colors-collection'

const ISymbol = require './symbol.svg'

export tag Plugin < details

	def parseColor c
		let parse = CSSStyleValue.parse 'color', c
		unless parse isa CSSUnparsedValue then [ parse.toString ]

	def setData v
		@data = v
		@collection = Set.new
		for item in @data:querySelectorAll '[style]'
			parseColor( item:style:color ).map( do|c| @collection.add c ) if item:style:color
			@collection.add item:style:backgroundColor if item:style:backgroundColor
			@collection.add item:style:borderColor if item:style:borderColor
			@collection.add item:style:boxShadow if item:style:boxShadow
			@collection.add item:style:textShadow if item:style:textShadow
			@collection.add item:style:outlineColor if item:style:outlineColor
		self

	def commandExec e
		data.execCommand 'styleWithCSS', true
		data.execCommand 'hiliteColor', false, @colors.value
		data.execCommand 'styleWithCSS', false

	def value
		@data.getSelection:focusNode and @data.getSelection:focusNode:parentElement:style:backgroundColor

	def setCurrentColor e
		@colors.value = value or "#000"  unless dom:open

	def render
		<self :tap.setCurrentColor>
			<summary> <kbd> <svg:svg css:fill=value> <svg:use href="{ ISymbol }#symbol">
			<s> <ColorsCollection[ Array.from @collection.values ]@colors hue=[] :input.commandExec>
