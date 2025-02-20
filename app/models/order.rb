class Order
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  field :pagamento_id, type: String
  field :total, type: Float
  field :status, type: String, default: 'in_progress' # Possíveis: approved, in_progress, rejected

  validates :user, presence: true
  validates :total, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :status, inclusion: { in: ['approved', 'in_progress', 'rejected'] }

  has_many :order_items

  # Retorna o status formatado em português
  def status_formatado
    case status
    when 'approved'
      'Aprovado'
    when 'in_progress'
      'Em Progresso'
    when 'rejected'
      'Rejeitado'
    else
      status
    end
  end

  # Cria um pedido de forma simples a partir do valor total e do usuário
  def self.criar_do_carrinho(total, usuario)
    return nil if total.nil? || usuario.nil?
    create(user: usuario, total: total)
  end
end