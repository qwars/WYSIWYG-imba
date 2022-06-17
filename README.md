# WYSIWYG-imba

Editor WYSIWYG

## Install

`git submodule add git@github.com:qwars/WYSIWYG-imba.git {patch-widgets-folder/editor-wysiwyg}`

`yarn add codemirror@5 colord`

`git submodule update --init --recursive --remote` - забрать изменения

## Import

```
import Widget as EditorWYSIWYG from './path-widgets-folder/editor-wysiwyg'

... any tag ...

def inputContent e
    console.log e.data # edit content 

def render
    <self>
    
        .... any ... 
        
        <EditorWYSIWYG[ content ] :input.inputContent >
