
import './index.styl'

const ISymbol = require './symbol.svg'

tag FormCreateContent < form
	@classes = ['FormCreateContentVideo']

	def selectMediaState type
		data = document.createElement type

	def render
		<self>
			unless data and ['VIDEO','AUDIO'].includes data:nodeName then <section>
				<kbd :tap.selectMediaState('VIDEO')> <svg:svg> <svg:use href="{ ISymbol }#symbol-video">
				<kbd :tap.selectMediaState('AUDIO')> <svg:svg> <svg:use href="{ ISymbol }#symbol-audio">


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
		Figure:style = 'display: inline-block; padding: 0px; margin: 0px'
		Figure:contentEditable = false
		rng.surroundContents Figure
		const FigCaption = Figure.appendChild document.createElement 'figcaption'
		FigCaption:contentEditable = true
		FigCaption:innerHTML = ' '
		FigCaption.addEventListener 'focus', self:focusFigCaption.bind self
		FigCaption.addEventListener 'blur', self:blurFigCaption.bind self


	def setup
		data:head.querySelector('style.IframeStyle'):sheet.insertRule 'video + figcaption:empty:before, audio + figcaption:empty:before { content: "Title is empty"; color: GrayText }'
		Array.from data.querySelectorAll( 'video, audio' ), do|item|
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
			let p = @data.getSelection:anchorNode;
			while p = parent:parentElement
				unless p:nodeName === 'FIGURE' then @ancor = null
				else
					break @ancor = p:firstElementChild
		@media = @ancor and ['VIDEO','AUDIO'].includes( @ancor:nodeName )  and @ancor:nodeName
		self

	def render
		<self>
			<summary>
				if @media === 'VIDEO' then <kbd.active> <svg:svg> <svg:use href="{ ISymbol }#symbol-video">
				elif @media === 'AUDIO' then <kbd.active> <svg:svg> <svg:use href="{ ISymbol }#symbol-audio">
				else <kbd> <svg:svg> <svg:use href="{ ISymbol }#symbol">
			<s> <FormCreateContent[ @ancor ]@formstate :tap.silence.stop>
