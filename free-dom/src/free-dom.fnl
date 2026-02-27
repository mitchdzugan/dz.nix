(import-macros __ :__)

(__.module
 (loc Value (_.class :Value))
 (fn Value.initialize [self type params]
   (set self.type type)
   (set self.params params))

 (loc StaticValue (Value:subclass :StaticValue))

 (fn StaticValue.initialize [self val]
   (Value.initialize self :Static [val]))

 (loc Element (_.class :Element))
 (loc HtmlElement (Element:subclass :HtmlElement))

 (fn HtmlElement.initialize [self tag attrs children]
   (set self.tag tag)
   (set self.attrs attrs)
   (set self.children children))

 (_.dbg (HtmlElement:new :div {} [(StaticValue 1)])))
