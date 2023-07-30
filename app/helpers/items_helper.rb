module ItemsHelper
  def needy_id_field(needy)
    if needy.author.nil?
      select_tag "item[needy_id]", options_from_collection_for_select(Needy.all, :id, :name)
    else
      hidden_field_tag "item[needy_id]", item.needy_id
    end
  end
end
