EnforcedScopeError = Class.new(StandardError)

module BaseExtensions
end

module RelationExtensions
  def using_enforced_scope?
    @using_enforced_scope
  end

  def with_enforced_scope
    @using_enforced_scope = true
    self
  end

  def load
    fail(EnforcedScopeError, 'Did not specify any of the required scopes') unless using_enforced_scope?
    super
  end
end

module ScopingExtensions
  def scope(name, body, &block)
    super
  end

  def enforced(&blk)
    blk.call.with_enforced_scope
  end
end

module ActiveRecord
  class Base
    class << self
      prepend BaseExtensions
      prepend ScopingExtensions
    end
  end

  class Relation
    prepend RelationExtensions
  end

  module Scoping
    module Named
      module ClassMethods
        prepend ScopingExtensions
      end
    end
  end
end
