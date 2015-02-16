module Shoppe
  class ProductCategory < ActiveRecord::Base
    validate { errors.add :base, :can_belong_to_root if self.parent && self.parent.parent }

    has_many :subcats, -> { order(:name => :asc) }, :class_name => 'Shoppe::ProductCategory', :foreign_key => 'parent_id', :dependent => :destroy

    belongs_to :parent, :class_name => 'Shoppe::ProductCategory', :foreign_key => 'parent_id'

    scope :root, -> { where(:parent_id => nil).order( :name => :asc) }
    scope :get_subcats, -> { where('parent_id is not null').order( :name => :asc) }

    def has_subcats?
      !subcat.empty?
    end

    def default_subcat
      return nil if self.parent
      @default_variant ||= self.subcat.select { |v| v.default? }.first
    end

    def subcat?
      !self.parent_id.blank?
    end

  end
end
