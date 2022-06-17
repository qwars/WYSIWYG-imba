# https://developer.mozilla.org/en-US/docs/Web/HTML/Element/img

import './index.styl'

const ISymbol = require './symbol.svg'

import Widget as InputUnits from '../../input-units'

tag FormCreateContent < form

	def inputStateStyle e
		data:style:width = @width.toString
		data:style:height = @height.toString

	def preloadFile e
		console.log e

	def computed
		unless data then {}
		else
			let computed = window.getComputedStyle( data )
			if data:style:width then computed:width = data:style:width
			if data:style:height then computed:height = data:style:height
			computed

	def render
		<self.FormCreateContentImage>
			<figure>
				<label>
					<input type="file" accept='image/*' :change.preloadFile>
					unless data then <aside>
						<dfn> "Upload image"
						<abbr> <svg:svg> <svg:use href="{ ISymbol }#cloud-upload">
					else console.dir data
				<figcaption data-placeholder="Title for image" contenteditable=true> data and data:alt or data and data:title
			<section>
				<InputUnits[ computed:width ]@width disabled=!data :input.stop.silence.inputStateStyle> "width"
				<InputUnits[ computed:height ]@height disabled=!data :input.stop.silence.inputStateStyle> "height"
			<button.active> data ? "Update" : "Create"

export tag Plugin < details

	def focusFigCaption e
		e:target:textContent = '' unless e:target:textContent.trim
		Imba.root.dom.click

	def blurFigCaption e
		e:target:textContent = ' ' unless e:target:textContent.trim
		Imba.root.dom.click

	def updateContentFigure item
		const rng = document.createRange
		rng.setStartBefore item
		rng.setEndAfter item
		const Figure = document.createElement 'figure'
		Figure:contentEditable = false
		Figure:style = 'display: inline-block; padding: 0px; margin: 0px'
		rng.surroundContents Figure
		const FigCaption = Figure.appendChild document.createElement 'figcaption'
		FigCaption:contentEditable = true
		FigCaption:innerHTML = ' '
		FigCaption.addEventListener 'focus', self:focusFigCaption.bind self
		FigCaption.addEventListener 'blur', self:blurFigCaption.bind self

	def setup
		data:head.querySelector('style.IframeStyle'):sheet.insertRule 'img + figcaption:empty:before { content: "Title is empty"; color: GrayText }'
		Array.from data.querySelectorAll( 'img' ), do|item|
			unless item:parentElement:nodeName === 'FIGURE' then updateContentFigure item
			else
				item:parentElement:nodeName.addEventListener 'focus', self:focusFigCaption.bind self
				item:parentElement:nodeName.addEventListener 'blur', self:blurFigCaption.bind self


	def setData v
		@data = v
		unless @data.getSelection:anchorNode then @ancor = null
		elif @data.getSelection:anchorNode:nodeName  === 'FIGCAPTION' then @ancor = @data.getSelection:anchorNode:parentElement:firstElementChild
		elif @data.getSelection:anchorNode:nodeName  === 'FIGURE' then @ancor = @data.getSelection:anchorNode:firstElementChild
		elif @data.getSelection:anchorNode:parentElement:nodeName  === 'FIGCAPTION' then @ancor = @data.getSelection:anchorNode:parentElement:parentElement:firstElementChild
		else
			let parent = @data.getSelection:anchorNode
			while parent = parent:parentElement
				unless parent:nodeName === 'FIGURE' then @ancor = null
				else
					break @ancor = parent:firstElementChild

		self

	def render
		<self>
			<summary> <kbd .active=(@ancor and @ancor:nodeName === 'IMG')> <svg:svg> <svg:use href="{ ISymbol }#symbol">
			<s> <FormCreateContent[ @ancor ]@formstate :tap.silence.stop>
