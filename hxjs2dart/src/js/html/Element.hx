/*
 * Copyright (C)2005-2013 Haxe Foundation
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */

// This file is generated, do not edit!
package js.html;

/** <p>This chapter provides a brief reference for the general methods, properties, and events available to most HTML and XML elements in the Gecko DOM.</p>
<p>Various W3C specifications apply to elements:</p>
<ul> <li><a class="external" rel="external" href="http://www.w3.org/TR/DOM-Level-2-Core/" title="http://www.w3.org/TR/DOM-Level-2-Core/" target="_blank">DOM Core Specification</a>—describes the core interfaces shared by most DOM objects in HTML and XML documents</li> <li><a class="external" rel="external" href="http://www.w3.org/TR/DOM-Level-2-HTML/" title="http://www.w3.org/TR/DOM-Level-2-HTML/" target="_blank">DOM HTML Specification</a>—describes interfaces for objects in HTML and XHTML documents that build on the core specification</li> <li><a class="external" rel="external" href="http://www.w3.org/TR/DOM-Level-2-Events/" title="http://www.w3.org/TR/DOM-Level-2-Events/" target="_blank">DOM Events Specification</a>—describes events shared by most DOM objects, building on the DOM Core and <a class="external" rel="external" href="http://www.w3.org/TR/DOM-Level-2-Views/" title="http://www.w3.org/TR/DOM-Level-2-Views/" target="_blank">Views</a> specifications</li> <li><a class="external" title="http://www.w3.org/TR/ElementTraversal/" rel="external" href="http://www.w3.org/TR/ElementTraversal/" target="_blank">Element Traversal Specification</a>—describes the new attributes that allow traversal of elements in the DOM&nbsp;tree 
<span>New in <a rel="custom" href="https://developer.mozilla.org/en/Firefox_3.5_for_developers">Firefox 3.5</a></span>
</li>
</ul>
<p>The articles listed here span the above and include links to the appropriate W3C DOM specification.</p>
<p>While these interfaces are generally shared by most HTML and XML elements, there are more specialized interfaces for particular objects listed in the DOM HTML Specification. Note, however, that these HTML&nbsp;interfaces are "only for [HTML 4.01] and [XHTML 1.0] documents and are not guaranteed to work with any future version of XHTML." The HTML 5 draft does state it aims for backwards compatibility with these HTML&nbsp;interfaces but says of them that "some features that were formerly deprecated, poorly supported, rarely used or considered unnecessary have been removed." One can avoid the potential conflict by moving entirely to DOM&nbsp;XML attribute methods such as <code>getAttribute()</code>.</p>
<p><code><a rel="custom" href="https://developer.mozilla.org/en/DOM/HTMLHtmlElement">Html</a></code>
, <code><a rel="custom" href="/api/js/html/HeadElement">Head</a></code>
, <code><a rel="custom" href="https://developer.mozilla.org/en/DOM/HTMLLinkElement">Link</a></code>
, <code><a rel="custom" href="/api/js/html/TitleElement">Title</a></code>
, <code><a rel="custom" href="/api/js/html/MetaElement">Meta</a></code>
, <code><a rel="custom" href="/api/js/html/BaseElement">Base</a></code>
, <code><a rel="internal" href="https://developer.mozilla.org/Article_not_found?uri=en/DOM/HTMLIsIndexElement" class="new">IsIndex</a></code>
, <code><a rel="custom" href="/api/js/html/StyleElement">Style</a></code>
, <code><a rel="custom" href="/api/js/html/BodyElement">Body</a></code>
, <code><a rel="custom" href="/api/js/html/FormElement">Form</a></code>
, <code><a rel="custom" href="/api/js/html/SelectElement">Select</a></code>
, <code><a rel="internal" href="https://developer.mozilla.org/Article_not_found?uri=en/DOM/HTMLOptGroupElement" class="new">OptGroup</a></code>
, <a title="en/HTML/Element/HTMLOptionElement" rel="internal" href="https://developer.mozilla.org/en/HTML/Element/HTMLOptionElement" class="new ">Option</a>, <code><a rel="custom" href="/api/js/html/InputElement">Input</a></code>
, <code><a rel="custom" href="/api/js/html/TextAreaElement">TextArea</a></code>
, <code><a rel="custom" href="/api/js/html/ButtonElement">Button</a></code>
, <code><a rel="custom" href="/api/js/html/LabelElement">Label</a></code>
, <code><a rel="custom" href="/api/js/html/FieldSetElement">FieldSet</a></code>
, <code><a rel="custom" href="/api/js/html/LegendElement">Legend</a></code>
, <code><a rel="internal" href="https://developer.mozilla.org/Article_not_found?uri=en/DOM/HTMLUListElement" class="new">UList</a></code>
, <code><a rel="internal" href="https://developer.mozilla.org/Article_not_found?uri=en/DOM/OList" class="new">OList</a></code>
, <code><a rel="internal" href="https://developer.mozilla.org/Article_not_found?uri=en/DOM/DList" class="new">DList</a></code>
, <code><a rel="internal" href="https://developer.mozilla.org/Article_not_found?uri=en/DOM/Directory" class="new">Directory</a></code>
, <code><a rel="internal" href="https://developer.mozilla.org/Article_not_found?uri=en/DOM/Menu" class="new">Menu</a></code>
, <code><a rel="internal" href="https://developer.mozilla.org/Article_not_found?uri=en/DOM/LI" class="new">LI</a></code>
, <code><a rel="internal" href="https://developer.mozilla.org/Article_not_found?uri=en/DOM/Div" class="new">Div</a></code>
, <code><a rel="internal" href="https://developer.mozilla.org/Article_not_found?uri=en/DOM/Paragraph" class="new">Paragraph</a></code>
, <code><a rel="internal" href="https://developer.mozilla.org/Article_not_found?uri=en/DOM/Heading" class="new">Heading</a></code>
, <code><a rel="internal" href="https://developer.mozilla.org/Article_not_found?uri=en/DOM/Quote" class="new">Quote</a></code>
, <code><a rel="internal" href="https://developer.mozilla.org/Article_not_found?uri=en/DOM/Pre" class="new">Pre</a></code>
, <code><a rel="internal" href="https://developer.mozilla.org/Article_not_found?uri=en/DOM/BR" class="new">BR</a></code>
, <code><a rel="internal" href="https://developer.mozilla.org/Article_not_found?uri=en/DOM/BaseFont" class="new">BaseFont</a></code>
, <code><a rel="internal" href="https://developer.mozilla.org/Article_not_found?uri=en/DOM/Font" class="new">Font</a></code>
, <code><a rel="internal" href="https://developer.mozilla.org/Article_not_found?uri=en/DOM/HR" class="new">HR</a></code>
, <code><a rel="internal" href="https://developer.mozilla.org/Article_not_found?uri=en/DOM/Mod" class="new">Mod</a></code>
, <code><a rel="custom" href="/api/js/html/AnchorElement">Anchor</a></code>
, <code><a rel="internal" href="https://developer.mozilla.org/Article_not_found?uri=en/DOM/Image" class="new">Image</a></code>
, <code><a rel="custom" href="/api/js/html/ObjectElement">Object</a></code>
, <code><a rel="internal" href="https://developer.mozilla.org/Article_not_found?uri=en/DOM/Param" class="new">Param</a></code>
, <code><a rel="internal" href="https://developer.mozilla.org/Article_not_found?uri=en/DOM/Applet" class="new">Applet</a></code>
, <code><a rel="internal" href="https://developer.mozilla.org/Article_not_found?uri=en/DOM/Map" class="new">Map</a></code>
, <code><a rel="internal" href="https://developer.mozilla.org/Article_not_found?uri=en/DOM/Area" class="new">Area</a></code>
, <code><a rel="internal" href="https://developer.mozilla.org/Article_not_found?uri=en/DOM/Script" class="new">Script</a></code>
, <code><a rel="custom" href="/api/js/html/TableElement">Table</a></code>
, <code><a rel="internal" href="https://developer.mozilla.org/Article_not_found?uri=en/DOM/TableCaption" class="new">TableCaption</a></code>
, <code><a rel="internal" href="https://developer.mozilla.org/Article_not_found?uri=en/DOM/TableCol" class="new">TableCol</a></code>
, <code><a rel="internal" href="https://developer.mozilla.org/Article_not_found?uri=en/DOM/TableSection" class="new">TableSection</a></code>
, <code><a rel="custom" href="/api/js/html/TableRowElement">TableRow</a></code>
, <code><a rel="internal" href="https://developer.mozilla.org/Article_not_found?uri=en/DOM/TableCell" class="new">TableCell</a></code>
, <code><a rel="internal" href="https://developer.mozilla.org/Article_not_found?uri=en/DOM/FrameSet" class="new">FrameSet</a></code>
, <code><a rel="internal" href="https://developer.mozilla.org/Article_not_found?uri=en/DOM/Frame" class="new">Frame</a></code>
, <code><a rel="custom" href="/api/js/html/IFrameElement">IFrame</a></code>
</p><br><br>
Documentation for this class was provided by <a href="https://developer.mozilla.org/en/DOM/element">MDN</a>. */
@:native("Element")
@:library("dart:html")
extern class Element extends Node
{
	static inline var ALLOW_KEYBOARD_INPUT : Int = 1;

	var accessKey : String;

	/** The number of child nodes that are elements. */
	var childElementCount(default,null) : Int;

	/** A live <code><a rel="internal" href="https://developer.mozilla.org/Article_not_found?uri=en/XPCOM_Interface_Reference/nsIDOMNodeList&amp;ident=nsIDOMNodeList" class="new">nsIDOMNodeList</a></code>
 of the current child elements. */
	var children(default,null) : HTMLCollection;

	/** Token list of class attribute */
	var classList(default,null) : DOMTokenList;

	/** Gets/sets the class of the element. */
	var className : String;

	/** The inner height of an element. */
	var clientHeight(default,null) : Int;

	/** The width of the left border of an element. */
	var clientLeft(default,null) : Int;

	/** The width of the top border of an element. */
	var clientTop(default,null) : Int;

	/** The inner width of an element. */
	var clientWidth(default,null) : Int;

	/** Gets/sets whether or not the element is editable. Setter throws DOMException. */
	var contentEditable : String;

	/** Allows access to read and write custom data attributes on the element. */
	var dataset(default,null) : DOMStringMap;

	/** Gets/sets the directionality of the element. */
	var dir : String;

	var draggable : Bool;

	var dropzone : String;

	/** The first direct child element of an element, or <code>null</code> if the element has no child elements. */
	var firstElementChild(default,null) : Element;

	var hidden : Bool;

	/** Gets/sets the id of the element. */
	var id : String;

	/** Gets/sets the markup of the element's content. Setter throws DOMException. */
	var innerHTML : String;

	/** Setter throws DOMException. */
	var innerText(get, set) : String;
    private inline function get_innerText():String return untyped this.text;
    private inline function set_innerText(v:String):String return untyped this.text = v;

	/** Indicates whether or not the content of the element can be edited. Read only. */
	var isContentEditable(default,null) : Bool;

	/** Gets/sets the language of an element's attributes, text, and element contents. */
	var lang : String;

	/** The last direct child element of an element, or <code>null</code> if the element has no child elements. */
	var lastElementChild(default,null) : Element;

	/** The element immediately following the given one in the tree, or <code>null</code> if there's no sibling node. */
	var nextElementSibling(default,null) : Element;

	/** The height of an element, relative to the layout. */
	var offsetHeight(default,null) : Int;

	/** The distance from this element's left border to its <code>offsetParent</code>'s left border. */
	var offsetLeft(default,null) : Int;

	/** The element from which all offset calculations are currently computed. */
	var offsetParent(default,null) : Element;

	/** The distance from this element's top border to its <code>offsetParent</code>'s top border. */
	var offsetTop(default,null) : Int;

	/** The width of an element, relative to the layout. */
	var offsetWidth(default,null) : Int;

    var onabort(get, set) : EventListener;
    private inline function get_onabort():EventListener return untyped this.onAbort;
    private inline function set_onabort(e:EventListener):EventListener return untyped this.onAbort.listen(e);

	var onbeforecopy(get, set)  : EventListener;
    private inline function get_onbeforecopy():EventListener return untyped this.onBeforeCopy;
    private inline function set_onbeforecopy(e:EventListener):EventListener return untyped this.onBeforeCopy.listen(e);

	var onbeforecut(get, set) : EventListener;
    private inline function get_onbeforecut():EventListener return untyped this.onBeforeCut;
    private inline function set_onbeforecut(e:EventListener):EventListener return untyped this.onBeforeCut.listen(e);

	var onbeforepaste(get, set) : EventListener;
    private inline function get_onbeforepaste():EventListener return untyped this.onBeforePaste;
    private inline function set_onbeforepaste(e:EventListener):EventListener return untyped this.onBeforePaste.listen(e);

	/** Returns the event handling code for the blur event. */
	var onblur(get, set) : EventListener;
    private inline function get_onblur():EventListener return untyped this.onBlur;
    private inline function set_onblur(e:EventListener):EventListener return untyped this.onBlur.listen(e);

	/** Returns the event handling code for the change event. */
	var onchange(get, set) : EventListener;
    private inline function get_onchange():EventListener return untyped this.onChange;
    private inline function set_onchange(e:EventListener):EventListener return untyped this.onChange.listen(e);

	/** Returns the event handling code for the click event. */
	var onclick(get, set) : EventListener;
    private inline function get_onclick():EventListener return untyped this.onClick;
    private inline function set_onclick(e:EventListener):EventListener return untyped this.onClick.listen(e);

	/** Returns the event handling code for the contextmenu event. */
	var oncontextmenu(get, set) : EventListener;
    private inline function get_oncontextmenu():EventListener return untyped this.onContextMenu;
    private inline function set_oncontextmenu(e:EventListener):EventListener return untyped this.onContextMenu.listen(e);

	/** Returns the event handling code for the copy event. */
	var oncopy(get, set) : EventListener;
    private inline function get_oncopy():EventListener return untyped this.onCopy;
    private inline function set_oncopy(e:EventListener):EventListener return untyped this.onCopy.listen(e);

	/** Returns the event handling code for the cut event. */
	var oncut(get, set) : EventListener;
    private inline function get_oncut():EventListener return untyped this.onCut;
    private inline function set_oncut(e:EventListener):EventListener return untyped this.onCut.listen(e);

	/** Returns the event handling code for the dblclick event. */
	var ondblclick(get, set) : EventListener;
    private inline function get_ondblclick():EventListener return untyped this.onDoubleClick;
    private inline function set_ondblclick(e:EventListener):EventListener return untyped this.onDoubleClick.listen(e);

	var ondrag(get, set) : EventListener;
    private inline function get_ondrag():EventListener return untyped this.onDrag;
    private inline function set_ondrag(e:EventListener):EventListener return untyped this.onDrag.listen(e);

	var ondragend(get, set) : EventListener;
    private inline function get_ondragend():EventListener return untyped this.onDragEnd;
    private inline function set_ondragend(e:EventListener):EventListener return untyped this.onDragEnd.listen(e);

	var ondragenter(get, set) : EventListener;
    private inline function get_ondragenter():EventListener return untyped this.onDragEnter;
    private inline function set_ondragenter(e:EventListener):EventListener return untyped this.onDragEnter.listen(e);

	var ondragleave(get, set) : EventListener;
    private inline function get_ondragleave():EventListener return untyped this.onDragLeave;
    private inline function set_ondragleave(e:EventListener):EventListener return untyped this.onDragLeave.listen(e);

	var ondragover(get, set) : EventListener;
    private inline function get_ondragover():EventListener return untyped this.onDragOver;
    private inline function set_ondragover(e:EventListener):EventListener return untyped this.onDragOver.listen(e);

	var ondragstart(get, set) : EventListener;
    private inline function get_ondragstart():EventListener return untyped this.onDragStart;
    private inline function set_ondragstart(e:EventListener):EventListener return untyped this.onDragStart.listen(e);

	var ondrop(get, set) : EventListener;
    private inline function get_ondrop():EventListener return untyped this.onDrop;
    private inline function set_ondrop(e:EventListener):EventListener return untyped this.onDrop.listen(e);

	var onerror(get, set) : EventListener;
    private inline function get_onerror():EventListener return untyped this.onError;
    private inline function set_onerror(e:EventListener):EventListener return untyped this.onError.listen(e);

	/** Returns the event handling code for the focus event. */
	var onfocus(get, set) : EventListener;
    private inline function get_onfocus():EventListener return untyped this.onFocus;
    private inline function set_onfocus(e:EventListener):EventListener return untyped this.onFocus.listen(e);

	var onfullscreenchange(get, set) : EventListener;
    private inline function get_onfullscreenchange():EventListener return untyped this.onFullscreenChange;
    private inline function set_onfullscreenchange(e:EventListener):EventListener return untyped this.onFullscreenChange.listen(e);

	var onfullscreenerror(get, set) : EventListener;
    private inline function get_onfullscreenerror():EventListener return untyped this.onFullscreenError;
    private inline function set_onfullscreenerror(e:EventListener):EventListener return untyped this.onFullscreenError.listen(e);

	var oninput(get, set) : EventListener;
    private inline function get_oninput():EventListener return untyped this.onInput;
    private inline function set_oninput(e:EventListener):EventListener return untyped this.onInput.listen(e);

	var oninvalid(get, set) : EventListener;
    private inline function get_oninvalid():EventListener return untyped this.onInvalid;
    private inline function set_oninvalid(e:EventListener):EventListener return untyped this.onInvalid.listen(e);

	/** Returns the event handling code for the keydown event. */
	var onkeydown(get, set) : EventListener;
    private inline function get_onkeydown():EventListener return untyped this.onKeyDown;
    private inline function set_onkeydown(e:EventListener):EventListener return untyped this.onKeyDown.listen(e);

	/** Returns the event handling code for the keypress event. */
	var onkeypress(get, set) : EventListener;
    private inline function get_onkeypress():EventListener return untyped this.onKeyPress;
    private inline function set_onkeypress(e:EventListener):EventListener return untyped this.onKeyPress.listen(e);

	/** Returns the event handling code for the keyup event. */
	var onkeyup(get, set) : EventListener;
    private inline function get_onkeyup():EventListener return untyped this.onKeyUp;
    private inline function set_onkeyup(e:EventListener):EventListener return untyped this.onKeyUp.listen(e);

	var onload(get, set) : EventListener;
    private inline function get_onload():EventListener return untyped this.onLoad;
    private inline function set_onload(e:EventListener):EventListener return untyped this.onLoad.listen(e);

	/** Returns the event handling code for the mousedown event. */
	var onmousedown(get, set) : EventListener;
    private inline function get_onmousedown():EventListener return untyped this.onMouseDown;
    private inline function set_onmousedown(e:EventListener):EventListener return untyped this.onMouseDown.listen(e);

	/** Returns the event handling code for the mousemove event. */
	var onmousemove(get, set) : EventListener;
    private inline function get_onmousemove():EventListener return untyped this.onMouseMove;
    private inline function set_onmousemove(e:EventListener):EventListener return untyped this.onMouseMove.listen(e);

	/** Returns the event handling code for the mouseout event. */
	var onmouseout(get, set) : EventListener;
    private inline function get_onmouseout():EventListener return untyped this.onMouseOut;
    private inline function set_onmouseout(e:EventListener):EventListener return untyped this.onMouseOut.listen(e);

	/** Returns the event handling code for the mouseover event. */
	var onmouseover(get, set) : EventListener;
    private inline function get_onmouseover():EventListener return untyped this.onMouseOver;
    private inline function set_onmouseover(e:EventListener):EventListener return untyped this.onMouseOver.listen(e);

	/** Returns the event handling code for the mouseup event. */
	var onmouseup(get, set) : EventListener;
    private inline function get_onmouseup():EventListener return untyped this.onMouseUp;
    private inline function set_onmouseup(e:EventListener):EventListener return untyped this.onMouseUp.listen(e);

	var onmousewheel(get, set) : EventListener;
    private inline function get_onmousewheel():EventListener return untyped this.onMouseWheel;
    private inline function set_onmousewheel(e:EventListener):EventListener return untyped this.onMouseWheel.listen(e);

	/** Returns the event handling code for the paste event. */
	var onpaste(get, set) : EventListener;
    private inline function get_onpaste():EventListener return untyped this.onPaste;
    private inline function set_onpaste(e:EventListener):EventListener return untyped this.onPaste.listen(e);

	var onreset(get, set) : EventListener;
    private inline function get_onreset():EventListener return untyped this.onReset;
    private inline function set_onreset(e:EventListener):EventListener return untyped this.onReset.listen(e);

	/** Returns the event handling code for the scroll event. */
	var onscroll(get, set) : EventListener;
    private inline function get_onscroll():EventListener return untyped this.onScroll;
    private inline function set_onscroll(e:EventListener):EventListener return untyped this.onScroll.listen(e);

	var onsearch(get, set) : EventListener;
    private inline function get_onsearch():EventListener return untyped this.onSearch;
    private inline function set_onsearch(e:EventListener):EventListener return untyped this.onSearch.listen(e);

	var onselect(get, set) : EventListener;
    private inline function get_onselect():EventListener return untyped this.onSelect;
    private inline function set_onselect(e:EventListener):EventListener return untyped this.onSelect.listen(e);

	var onselectstart(get, set) : EventListener;
    private inline function get_onselectstart():EventListener return untyped this.onSelectStart;
    private inline function set_onselectstart(e:EventListener):EventListener return untyped this.onSelectStart.listen(e);

	var onsubmit(get, set) : EventListener;
    private inline function get_onsubmit():EventListener return untyped this.onSubmit;
    private inline function set_onsubmit(e:EventListener):EventListener return untyped this.onSubmit.listen(e);

	var ontouchcancel(get, set) : EventListener;
    private inline function get_ontouchcancel():EventListener return untyped this.onTouchCancel;
    private inline function set_ontouchcancel(e:EventListener):EventListener return untyped this.onTouchCancel.listen(e);

	var ontouchend(get, set) : EventListener;
    private inline function get_ontouchend():EventListener return untyped this.onTouchEnd;
    private inline function set_ontouchend(e:EventListener):EventListener return untyped this.onTouchEnd.listen(e);

	var ontouchmove(get, set) : EventListener;
    private inline function get_ontouchmove():EventListener return untyped this.onTouchMove;
    private inline function set_ontouchmove(e:EventListener):EventListener return untyped this.onTouchMove.listen(e);

	var ontouchstart(get, set) : EventListener;
    private inline function get_ontouchstart():EventListener return untyped this.onTouchStart;
    private inline function set_ontouchstart(e:EventListener):EventListener return untyped this.onTouchStart.listen(e);

	/** Gets the markup of the element including its content. When used as a setter, replaces the element with nodes parsed from the given string. Setter throws DOMException. */
	var outerHTML : String;

	/** Setter throws DOMException. */
	var outerText : String;

	/** The element immediately preceding the given one in the tree, or <code>null</code> if there is no sibling element. */
	var previousElementSibling(default,null) : Element;

	var pseudo : String;

	/** The scroll view height of an element. */
	var scrollHeight(default,null) : Int;

	/** Gets/sets the left scroll offset of an element. */
	var scrollLeft : Int;

	/** Gets/sets the top scroll offset of an element. */
	var scrollTop : Int;

	/** The scroll view width of an element. */
	var scrollWidth(default,null) : Int;

	/** Controls <a title="en/Controlling_spell_checking_in_HTML_forms" rel="internal" href="https://developer.mozilla.org/en/HTML/Controlling_spell_checking_in_HTML_forms">spell-checking</a> (present on all HTML&nbsp;elements) */
	var spellcheck : Bool;

	/** An object representing the declarations of an element's style attributes. */
	var style(default,null) : CSSStyleDeclaration;

	/** Gets/sets the position of the element in the tabbing order. */
	var tabIndex : Int;

	/** The name of the tag for the given element. */
	var tagName(default,null) : String;

	/** A string that appears in a popup box when mouse is over the element. */
	var title : String;

	var translate : Bool;

	function blur() : Void;

	function click() : Void;

	function focus() : Void;

	function getAttribute( name : String ) : String;

	function getAttributeNS( ?namespaceURI : String, localName : String ) : String;

	function getAttributeNode( name : String ) : Attr;

	function getAttributeNodeNS( ?namespaceURI : String, localName : String ) : Attr;

	function getBoundingClientRect() : ClientRect;

	function getClientRects() : ClientRectList;

	function getElementsByClassName( name : String ) : NodeList;

	function getElementsByTagName( name : String ) : NodeList;

	function getElementsByTagNameNS( ?namespaceURI : String, localName : String ) : NodeList;

	function hasAttribute( name : String ) : Bool;

	function hasAttributeNS( ?namespaceURI : String, localName : String ) : Bool;

	function insertAdjacentElement( where : String, element : Element ) : Element;

	function insertAdjacentHTML( where : String, html : String ) : Void;

	function insertAdjacentText( where : String, text : String ) : Void;

	function matchesSelector( selectors : String ) : Bool;

	function querySelector( selectors : String ) : Element;

	function querySelectorAll( selectors : String ) : NodeList;

	function remove() : Void;

	function removeAttribute( name : String ) : Void;

	function removeAttributeNS( namespaceURI : String, localName : String ) : Void;

	function removeAttributeNode( oldAttr : Attr ) : Attr;

	function requestFullScreen( flags : Int ) : Void;

	function requestFullscreen() : Void;

	function requestPointerLock() : Void;

	function scrollByLines( lines : Int ) : Void;

	function scrollByPages( pages : Int ) : Void;

	function scrollIntoView( ?alignWithTop : Bool ) : Void;

	function scrollIntoViewIfNeeded( ?centerIfNeeded : Bool ) : Void;

	function setAttribute( name : String, value : String ) : Void;

	function setAttributeNS( ?namespaceURI : String, qualifiedName : String, value : String ) : Void;

	function setAttributeNode( newAttr : Attr ) : Attr;

	function setAttributeNodeNS( newAttr : Attr ) : Attr;

}
