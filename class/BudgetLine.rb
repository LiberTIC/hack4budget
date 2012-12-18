# Budget information line
# Stored in database using MongoMapper
class BudgetLine
  include MongoMapper::Document
  
  key :exercice, Integer, :required => true
  key :d_r, String, :required => true
  key :i_f, String, :required => true
  key :ordre, Boolean
  key :code_chapitre, Integer
  key :code_ss_fonction, Integer
  key :code_article, Integer
  key :montant, Integer
  key :thematique, String
  key :modele, String
  timestamps!
end