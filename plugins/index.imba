
import Plugin as PluginUnformat from "./unformat"
import Plugin as PluginBold from "./bold"
import Plugin as PluginItalic from "./italic"
import Plugin as PluginOverline from "./overline"
import Plugin as PluginUnderline from "./underline"
import Plugin as PluginStrike from "./strike"
import Plugin as PluginAlignText from "./align-text"
import Plugin as PluginSup from "./sup"
import Plugin as PluginSub from "./sub"
import Plugin as PluginList from "./list"
import Plugin as PluginMark from "./mark"
import Plugin as PluginTrack from "./track"
import Plugin as PluginColor from "./color"
import Plugin as PluginImage from "./image"
import Plugin as PluginTable from "./table"
import Plugin as PluginTag from "./tag"
import Plugin as PluginHr from "./hr"

export const Plugins =
	"unformat": PluginUnformat
	"tag": PluginTag
	"color": PluginColor
	"bold": PluginBold
	"italic": PluginItalic
	"overline": PluginOverline
	"underline" : PluginUnderline
	"strike": PluginStrike
	"align-text": PluginAlignText
	"mark": PluginMark
	"sup": PluginSup
	"sub": PluginSub
	"hr": PluginHr
	"list": PluginList
	"image": PluginImage
	"track": PluginTrack
	"table": PluginTable