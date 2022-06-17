# template-ui-kid :: editor-wysiwyg

Editor WYSIWYG

## Install

`git submodule add -b editor-wysiwyg git@github.com:qwars/template-ui-kid.git patch-widgets-folder/editor-wysiwyg`

`yarn add codemirror@5 colord`

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
