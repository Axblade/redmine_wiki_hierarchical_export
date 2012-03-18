class ExportController < ApplicationController
  unloadable

  include RedmineWikiHierarchicalExport::Export::PDF

  def export
    parent_page = WikiPage.find_by_id(params[:id])
    content = parent_page.content.text.to_s + "\n"
    attachments = parent_page.attachments || Array.new
    if WikiPage.find_all_by_parent_id(parent_page.id).any?
      add_content(parent_page, content, attachments)
    end

    send_data wiki_to_pdf_with_children(parent_page.title, content, attachments),
              :filename => parent_page.title + '.pdf',
              :type => 'application/pdf',
              :disposition => 'attachment'
  end

  private
  def add_content(parent_page, content, attachments)
    children = WikiPage.find_all_by_parent_id(parent_page.id)
    children.each do |cp|
      content << "\n" + cp.content.text + "\n"
      attachments << cp.attachments if cp.attachments.any?
      add_content(cp, content, attachments) if WikiPage.find_all_by_parent_id(cp.id).any?
    end
  end
end
