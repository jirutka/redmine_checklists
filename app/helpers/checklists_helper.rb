# encoding: utf-8
#
# This file is a part of Redmine Checklists (redmine_checklists) plugin,
# issue checklists management plugin for Redmine
#
# Copyright (C) 2011-2026 RedmineUP
# http://www.redmineup.com/
#
# redmine_checklists is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# redmine_checklists is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with redmine_checklists.  If not, see <http://www.gnu.org/licenses/>.

module ChecklistsHelper

  def link_to_remove_checklist_fields(name, f, options={})
    f.hidden_field(:_destroy) + link_to(name, "javascript:void(0)", options)
  end

  def new_object(f, association)
    @new_object ||= f.object.class.reflect_on_association(association).klass.new
  end

  def checklist_fields(f, association)
    @fields ||= f.fields_for(association, new_object(f, association), :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
  end

  def new_or_show(f)
    object = f.respond_to?(:object) ? f.object : f

    if object.new_record?
      object.subject.present? ? 'show' : 'new'
    else
      'show'
    end
  end

  def custom_field_checklist_fields(custom_field)
    custom_field.fields_for(:checklist) do |new_checklist|
      new_checklist.fields_for(:new_checklist, RedmineChecklists::FieldFormat::ChecklistStruct.new({})) do |f|
        render(partial: 'common/custom_field_checklist_item', locals: {custom_field: f})
      end
    end
  end

  def custom_field_field_name(custom_field, ind, name)
    "#{custom_field.object_name}[checklist][#{ind}][#{name}]"
  end

  def done_css(f)
    if f.object.is_done
      "is-done-checklist-item"
    else
      ""
    end
  end

end
