
const ISymbol = require './symbol.svg'

const Tags =
	DIV: "Normal"
	SECTION: "Section"
	ASIDE: "Aside"
	P: "Paragraph"
	BLOCKQUOTE: "Blockquote"
	ADDRESS: "Address"
	H2: "Heading 2"
	H3: "Heading 3"
	H4: "Heading 4"
	H5: "Heading 5"
	H6: "Heading 6"
	H1: "Heading 1"


export tag Plugin < details

	def commandExec value
		data.execCommand 'formatBlock', false, value

	def render
		<self>
			<summary> <kbd> <svg:svg> <svg:use href="{ ISymbol }#symbol-{ @tag }">
			<s> <ul>
				for own propery, value of Tags
					<li :tap.commandExec( propery )> value
