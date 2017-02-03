class CreateIrrationalVerbs < ActiveRecord::Migration[5.0]
  def change
    create_table :irrational_verbs do |t|

      t.timestamps
    end
  end
end
