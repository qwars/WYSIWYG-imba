
import './index.styl'

const ISymbol = require './symbol.svg'

tag NavFormContentTable < form

	def setData v
		@data = v
		@selected = @data[0]
		self

	def selectElement item
		@selected = item
		render

	def render
		<self>
			<nav>
				<ul> for item, idx in data when [ 'TABLE', 'TBODY', 'THEAD', 'TFOOT', 'CAPTION', 'TH', 'TD' ].includes item:tagName
					<li .{ item:tagName.toLowerCase } .active=( item === @selected ) :tap.selectElement( item )> item:tagName
			<section>
				console.log @selected
			<button.active> data:length ? "Update" : "Create"


export tag Plugin < details

	def setData v
		@data = v
		let current = @data.getSelection:anchorNode
		@ancors = while current and current:parentElement then current = current:parentElement
		self

	def commandExec e
		data.execCommand 'styleWithCSS', true
		data.execCommand 'foreColor', false, e.data[0]
		data.execCommand 'styleWithCSS', false

	def render
		<self>
			<summary> <kbd> <svg:svg> <svg:use href="{ ISymbol }#symbol">
			<s> <NavFormContentTable[ @ancors ]>

