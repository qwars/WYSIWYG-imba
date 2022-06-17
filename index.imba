
import Plugins from './plugins'

import './index.styl'

const ISVG = require './simbols-icon.svg'

const PreloadFileData = do|file| Promise.new do|resolve|
	let reader = FileReader.new
	reader:onload = do |e| resolve e:target:result
	reader.readAsDataURL file

const removeFileData = do|file| Promise.new do|resolve|
	resolve undefined

tag IframeStyle < style
	def render
		<self> "
		html \{ min-height: 100%; height: 100%; padding: 0px; \}
		body \{ min-height: 100%; box-sizing: border-box;  padding: 1ex; margin: 0px; \}
		body:empty:before \{ content: '{ data or '' }'; color: GrayText \}
		body a \{ pointer-events: none; \}
		body * \{ outline: none \}
		"

tag IframeContent < iframe

	def createRangeState

	def mount
		if data and data.match />$/ then data += ' '
		srcdoc = data or ''
		dom.addEventListener 'load', do |e|
			Imba.mount <IframeStyle[ parent.placeholder ]>,  dom:contentDocument:head
			dom:contentDocument:body:contentEditable = true
			dom:contentDocument:body.addEventListener 'paste', do|e|
				if e:clipboardData then dom:contentDocument.execCommand 'insertText', false , ( e:originalEvent or e ):clipboardData.getData('text/plain').replace( /\s+/g, ' ').trim
				else if dom:contentWindow:clipboardData then dom:contentDocument:selection:createRange.pasteHTML dom:contentWindow:clipboardData.getData( 'Text' ).replace( /\s+/g, ' ').trim
				e.stopPropagation or e.preventDefault

			dom:contentDocument:body.addEventListener 'focus', do|e| for item in parent.querySelectorAll '[open]'
					item.dom:open = false
			dom:contentDocument:body.addEventListener 'mouseup', parent:render.bind parent
			dom:contentDocument:body.addEventListener 'keyup', parent:render.bind parent

			dom:contentDocument:storage = parent.storage
			parent.render

	def render
		<self>

export tag Widget
	prop placeholder
	prop storage default:
		upload: do|files| Promise.new do|resolve|
			resolve( await Promise.all Array.from files, do|f| PreloadFileData f )
		remove: do|files| Promise.new do|resolve|
			resolve( await Promise.all Array.from files, do|f| removeFileData f )

	prop plugins default: Object.keys Plugins

	@classes = ['editor-wysiwyg']

	def setup
		Imba.root.dom.addEventListener 'click', do|e|
			const detail = e.composedPath.filter( do|item| item:nodeName === 'DETAILS' )
			for item in querySelectorAll 'nav details.Plugin[open]'
				item.dom:open = false unless detail.includes item.dom

	def focusEditor e
		const detail = e.event.composedPath.filter( do|item| item:nodeName === 'DETAILS' )
		for item in querySelectorAll '[open]'
			item.dom:open = false unless detail.includes item.dom
		if detail then console.log detail
		else
			@editor.dom:contentDocument:body.focus

	def render
		<self>
			<IframeContent[ data ]@editor>
			<nav :input.silence.stop :tap.silence.stop.focusEditor :submit.silence.stop>
				unless @editor.dom:contentDocument then <.loading>
				else <ul> for item in @plugins when Plugin = Plugins[ item ]
						<li> <Plugin[ @editor.dom:contentDocument ]>
				<aside>
					<kbd> <svg:svg> <svg:use href="{ ISVG }#question-circle">
					<kbd> <svg:svg> <svg:use href="{ ISVG }#code">
					<kbd> <svg:svg> <svg:use href="{ ISVG }#sync">