# frozen_string_literal: true

module Frontco
  module Tags
    PAIRED_TAGS = %i[
      a abbr acronym address applet article aside audio
      b basefont bdi bdo big blockquote body button
      canvas caption center cite code colgroup
      data datalist dd del detailsdfn dialog dir div dl dt
      em
      fieldset figcaption figure font footer form frame frameset
      h1 h2 h3 h4 h5 h6
      head header html
      i iframe ins
      kbd
      label legend li
      main map mark meter
      nav noframes noscript
      object ol optgroup option output
      p picture pre progress
      q
      rp rt ruby
      s samp script section select small span strike strong style sub summary sup svg
      table tbody td template textarea tfoot th thead time title tr tt
      u ul
      var video
    ].freeze

    SINGLETON_TAGS = %i[
      area base br col command embed hr img input keygen
      link meta param source track wbr
    ].freeze
  end
end
