#!/usr/bin/env ruby

require 'helper'

class StickyTest < Test::Unit::TestCase

  include MicroMIDI
  include MIDIMessage
  include TestHelper

  def test_channel
    m = MicroMIDI.message
    msg = m.note "C0"
    assert_equal(NoteOn, msg.class)
    assert_equal(12, msg.note)
    assert_equal(0, msg.channel)
    
    m.channel 7
    msg = m.note "C0"
    assert_equal(NoteOn, msg.class)
    assert_equal(12, msg.note)
    assert_equal(7, msg.channel)
  end
  
  def test_channel_override
    m = MicroMIDI.message
    m.channel 7
    msg = m.note "C0", :channel => 3
    assert_equal(NoteOn, msg.class)
    assert_equal(12, msg.note)
    assert_equal(3, msg.channel)
    assert_equal(100, msg.velocity)
    
    msg = m.note "C0"
    assert_equal(NoteOn, msg.class)
    assert_equal(12, msg.note)
    assert_equal(7, msg.channel)
    assert_equal(100, msg.velocity)
  end
  
  def test_velocity
    m = MicroMIDI.message
    msg = m.note "C0"
    assert_equal(NoteOn, msg.class)
    assert_equal(12, msg.note)
    assert_equal(0, msg.channel)
    assert_equal(100, msg.velocity)
    
    m.velocity 10    
    msg = m.note "C0"
    assert_equal(NoteOn, msg.class)
    assert_equal(12, msg.note)
    assert_equal(0, msg.channel)
    assert_equal(10, msg.velocity)
  end

  def test_velocity_super_sticky
    m = MicroMIDI.message
    m.super_sticky
    
    msg = m.note "C0"
    assert_equal(NoteOn, msg.class)
    assert_equal(12, msg.note)
    assert_equal(0, msg.channel)
    assert_equal(100, msg.velocity)
    
    m.velocity 10    
    msg = m.note "C0", :velocity => 20
    assert_equal(NoteOn, msg.class)
    assert_equal(12, msg.note)
    assert_equal(0, msg.channel)
    assert_equal(20, msg.velocity)
    
    msg = m.note "C1"
    assert_equal(NoteOn, msg.class)
    assert_equal(24, msg.note)
    assert_equal(0, msg.channel)
    assert_equal(20, msg.velocity)
  end
        
end
