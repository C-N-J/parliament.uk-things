module ArticlesHelper
  def self.render_pdf(article)
    ApplicationController.render(
      pdf:      article.title,
      template: 'articles/pdf.html.haml',
      locals:   { article: article },
      layout:   false,
      encoding: 'UTF-8'
    )
  end
end
