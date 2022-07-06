# frozen_string_literal: true

require 'minitest/autorun'
require './lib/rgb'

class RgbTest < Minitest::Test
  def test_to_hex
    assert_equal '#000000', to_hex_3(0, 0, 0) #=>'#000000'
    assert_equal '#ffffff', to_hex_3(255, 255, 255) #=>'#ffffff'
    assert_equal '#043c78', to_hex_3(4, 60, 120) #=>'#043c78'
  end

  def test_to_ints
    assert_equal [0, 0, 0], to_ints_2('#000000') #=>[0,0,0]
    assert_equal [255, 255, 255], to_ints_2('#ffffff') #=>[255,255,255]
    assert_equal [4, 60, 120], to_ints_2('#043c78') #=>[4,60,120]
  end
end
