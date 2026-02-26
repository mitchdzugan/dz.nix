(import-macros __ :__)

(__.module
 (loc Element (_.class :Element))
 (fn Element.initialize [self tag attrs children]
   (set self.tag tag)
   (set self.attrs attrs)
   (set self.children children))

 (_.dbg (Element:new :div {} [])))
