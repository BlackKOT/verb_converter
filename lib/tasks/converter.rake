require "yaml/store"

namespace :converter do
  desc 'convert verbs'
  task proceed: :environment do

    store = YAML::Store.new(Rails.root.join("data.yml"))

    IrrationalVerb.all.each_with_index do |verb, main_index|

      store.transaction do
        store[verb.group_id] ||= {}
        store[verb.group_id][verb.form] ||= []
        store[verb.group_id][verb.form] << {word: verb.node.text, trans: verb.node.transcription}
        store[verb.group_id]['translations'] ||= []
        verb.node.translations.each do  |translation|
          store[verb.group_id]['translations'] << translation.text unless store[verb.group_id]['translations'].include?(translation.text)
          print "#{main_index} verb(s) \r"
          $stdout.flush
        end
      end
      # {
      #   1 => [
      #     {
      #       word: '',
      #       trans: ''
      #     }, ...
      # ],
      #   2 => [..],
      #   3 => ...,
      #   translations: []
      # }
      #
      #   {говорить => {val=>{1=>speak, 2=> talk}}}
      #
      #   {speak => {tr=>[spik],  val => {1=> говорить, 2=> понимать}, form =>{2=> spoke, 3=>spoken}}},
      #   {spoke => {tr=>[spouk], val => {1=> говорить, 2=> понимать, form =>{1=> speak, 3=>spoken}}}}

    end
  end
end