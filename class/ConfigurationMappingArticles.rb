# Struct for mapping configuration
# Read from CSV
class ConfigMappingArticles < Struct.new(:thematique, :modele, :chapitre, :fonction, :article)
  def comp(chapitre, fonction, article)
    return (self.chapitre == chapitre and self.fonction == fonction and self.article == article)
  end
end