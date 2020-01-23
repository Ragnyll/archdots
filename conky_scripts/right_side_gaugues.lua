require 'cairo'

colors = {
	dark_grey = {
		r = 35.9,
		g = 34.9,
		b = 36.9,
		a = .1
	},
	light_grey = {
		r = 52.9,
		g = 51.3,
		b = 54.6,
		a = .6
	},
	lighter_grey = { -- less transparency
		r = 52.9,
		g = 51.3,
		b = 54.6,
		a = .5
	}
}

value_font = "Fira Code"
default_font = "Consolas"

function conky_main()
    if conky_window == nil then
        return
    end
    local cs = cairo_xlib_surface_create(conky_window.display,
                                         conky_window.drawable,
                                         conky_window.visual,
                                         conky_window.width,
                                         conky_window.height)
    cr = cairo_create(cs)

	battery_and_brightness(cr)
	cpu_and_memory(cr)
	filesystem_gaugues(cr)
	up_and_down_speed(cr)

    cairo_destroy(cr)
    cairo_surface_destroy(cs)
    cr = nil
end

function battery_and_brightness(cr)
	-- these are coenctric rings, so the centroid must be the same between all of them.
	epicenter = {
		x = 350,
		y = 400
	}
	battery_gaugue(cr, epicenter)
	brightness_gaugue(cr, epicenter)

	-- write the small text beneath the the horizantal rule
	font_slant = CAIRO_FONT_SLANT_NORMAL
	font_face = CAIRO_FONT_WEIGHT_NORMAL
	cairo_select_font_face(cr, default_font, font_slant, font_face)
	cairo_set_font_size(cr, 12)
	cairo_set_source_rgba(cr, colors.dark_grey.r, colors.dark_grey.g, colors.dark_grey.b, colors.dark_grey.a)

	text = conky_parse("${uptime_short}") .. " UpTime"
	cairo_move_to(cr, 425, 373)
	cairo_show_text(cr, text)
	cairo_stroke(cr, text)


	brightness_val = math.floor((conky_parse("${cat /sys/class/backlight/intel_backlight/brightness}") / conky_parse("${cat /sys/class/backlight/intel_backlight/max_brightness}")) * 100)
	text = brightness_val .. "% Bright"
	cairo_move_to(cr, 425, 386)
	cairo_show_text(cr, text)
	cairo_stroke(cr)
end

function battery_gaugue(cr, epicenter)
	gaugue_props = {
		gaugue_name = "bat0",
		gaugue_value = conky_parse("${battery_percent BAT0}"),
		gaugue_max = 100,
		orientation = "right",
		colors = {
			free_color = colors.dark_grey,
			used_color = colors.light_grey,
			rule_color = colors.lighter_grey
		},
		meter = {
			x = epicenter.x, -- the center x offset relative to conf top left
			y = epicenter.y, -- the center y offset relative to conf top left
			r = 45,  -- the radius of the guage
			w = 4    -- the width of the stroke
		},
		rule = {
			w = 3,
			l = 365
		},
		annotation = {
			gaugue_name = "BAT0",
			unit = "%",
			value_font = value_font,
			default_font = default_font,
			font_size_large = 24,
			font_size_small = 12,
			value_loc = {
				x = 425,
				y = 353,
			},
			desc_loc = {
				x = 488,
				y = 353,
			},
			text_loc = {
				hr_len = 255,
				x = 425,
				y = 356,
			},
			accent_color = colors.lighter_grey,
			muted_color = colors.lighter_grey
		}
	}

	write_annotation(cr, gaugue_props)
	ring_gaugue(cr, gaugue_props)
end

function brightness_gaugue(cr, epicenter)
	gaugue_props = {
		gaugue_name = "brightness",
		gaugue_value = math.floor((conky_parse("${cat /sys/class/backlight/intel_backlight/brightness}") / conky_parse("${cat /sys/class/backlight/intel_backlight/max_brightness}")) * 100),
		gaugue_max = 100,
		colors = {
			free_color = colors.dark_grey,
			used_color = colors.light_grey,
			rule_color = colors.lighter_grey
		},
		meter = {
			x = epicenter.x, -- the center x offset relative to conf top left
			y = epicenter.y, -- the center y offset relative to conf top left
			r = 36,  -- the radius of the guage
			w = 10    -- the width of the stroke
		},
		annotation = {
			gaugue_name = "BRIGHT",
			unit = "%",
			value_font = value_font,
			default_font = default_font,
			font_size_large = 24,
			font_size_small = 12,
			text_loc = {
				hr_len = 0,
				x = 425,
				y = 356,
			},
			accent_color = colors.lighter_grey,
			muted_color = colors.lighter_grey
		}
	}
	draw_annotation_rule(cr, gaugue_props)
	ring_gaugue(cr, gaugue_props)
end

function cpu_and_memory(cr)
	epicenter = {
		x = 450,
		y = 575
	}
	cpu_gaugue(cr, epicenter)
	memory_gaugue(cr, epicenter)

	top_table(cr)
end

function cpu_gaugue(cr)
	gaugue_props = {
		gaugue_value = conky_parse("${cpu}"),
		gaugue_max = 100,
		colors = {
			free_color = colors.dark_grey,
			used_color = colors.light_grey,
			rule_color = colors.lighter_grey
		},
		meter = {
			x = epicenter.x, -- the center x offset relative to conf top left
			y = epicenter.y, -- the center y offset relative to conf top left
			r = 40,  -- the radius of the guage
			w = 4    -- the width of the stroke
		},
		rule = {
			w = 3,
			l = 285
		},
		annotation = {
			gaugue_name = "CPU",
			unit = "%",
			value_font = value_font,
			default_font = default_font,
			font_size_large = 24,
			font_size_small = 12,
			value_loc = {
				x = 523,
				y = 538,
			},
			desc_loc = {
				x = 570,
				y = 538,
			},
			text_loc = {
				hr_len = 160,
				x = 523,
				y = 541,
			},
			accent_color = colors.lighter_grey,
			muted_color = colors.lighter_grey
		}
	}

	write_annotation(cr, gaugue_props)
	ring_gaugue(cr, gaugue_props)
end

function memory_gaugue(cr)
	gaugue_props = {
		gaugue_value = conky_parse("${memperc}"),
		gaugue_max = 100,
		colors = {
			free_color = colors.dark_grey,
			used_color = colors.light_grey,
			rule_color = colors.lighter_grey
		},
		meter = {
			x = epicenter.x, -- the center x offset relative to conf top left
			y = epicenter.y, -- the center y offset relative to conf top left
			r = 32,  -- the radius of the guage
			w = 8    -- the width of the stroke
		}
	}

	ring_gaugue(cr, gaugue_props)
end

function top_table(cr)
	font_slant = CAIRO_FONT_SLANT_NORMAL
	font_face = CAIRO_FONT_WEIGHT_NORMAL
	cairo_select_font_face(cr, default_font, font_slant, font_face)
	cairo_set_font_size(cr, 12)
	cairo_set_source_rgba(cr, colors.dark_grey.r, colors.dark_grey.g, colors.dark_grey.b, colors.dark_grey.a)

	table_headers = "Name       CPU%  MEM%"
	cairo_move_to(cr, 523, 556)
	cairo_show_text(cr, table_headers)
	cairo_stroke(cr)

	process_name = conky_parse("${top name 1}")
	cairo_move_to(cr, 523, 568)
	cairo_show_text(cr, process_name)
	cairo_stroke(cr)
	process_cpu_perc = conky_parse("${top cpu 1}") .. "%"
	cairo_move_to(cr, 587, 568)
	cairo_show_text(cr, process_cpu_perc)
	cairo_stroke(cr)
	process_mem_perc = conky_parse("${top mem 1}") .. "%"
	cairo_move_to(cr, 630, 568)
	cairo_show_text(cr, process_mem_perc)
	cairo_stroke(cr)

	process_name = conky_parse("${top name 2}")
	cairo_move_to(cr, 523, 580)
	cairo_show_text(cr, process_name)
	cairo_stroke(cr)
	process_cpu_perc = conky_parse("${top cpu 2}") .. "%"
	cairo_move_to(cr, 587, 580)
	cairo_show_text(cr, process_cpu_perc)
	cairo_stroke(cr)
	process_mem_perc = conky_parse("${top mem 2}") .. "%"
	cairo_move_to(cr, 630, 580)
	cairo_show_text(cr, process_mem_perc)
	cairo_stroke(cr)

	process_name = conky_parse("${top name 3}")
	cairo_move_to(cr, 523, 592)
	cairo_show_text(cr, process_name)
	cairo_stroke(cr)
	process_cpu_perc = conky_parse("${top cpu 3}") .. "%"
	cairo_move_to(cr, 587, 592)
	cairo_show_text(cr, process_cpu_perc)
	cairo_stroke(cr)
	process_mem_perc = conky_parse("${top mem 3}") .. "%"
	cairo_move_to(cr, 630, 592)
	cairo_show_text(cr, process_mem_perc)
	cairo_stroke(cr)

	process_name = conky_parse("${top name 4}")
	cairo_move_to(cr, 523, 604)
	cairo_show_text(cr, process_name)
	cairo_stroke(cr)
	process_cpu_perc = conky_parse("${top cpu 4}") .. "%"
	cairo_move_to(cr, 587, 604)
	cairo_show_text(cr, process_cpu_perc)
	cairo_stroke(cr)
	process_mem_perc = conky_parse("${top mem 4}") .. "%"
	cairo_move_to(cr, 630, 604)
	cairo_show_text(cr, process_mem_perc)
	cairo_stroke(cr)
end


function up_and_down_speed(cr)
	epicenter = {
		x = 450,
		y = 750
	}

	gaugue_props = {
		gaugue_value = "wlp82s0",
		annotation = {
			unit = "",
			value_font = value_font,
			font_size_large = 24,
			text_loc = {
				hr_len = 160,
				x = 523,
				y = 718,
			},
			value_loc = {
				x = 523,
				y = 712,
			},
			accent_color = colors.lighter_grey,
			muted_color = colors.lighter_grey
		}
	}

	-- write out the up and down
	write_annotation_value(cr, gaugue_props)
	draw_annotation_rule(cr, gaugue_props)
	upspeed_gaugue(cr, epicenter)
	downspeed_gaugue(cr, epicenter)

	-- write out the values
	font_slant = CAIRO_FONT_SLANT_NORMAL
	font_face = CAIRO_FONT_WEIGHT_NORMAL
	cairo_select_font_face(cr, default_font, font_slant, font_face)
	cairo_set_font_size(cr, 12)
	cairo_set_source_rgba(cr, colors.dark_grey.r, colors.dark_grey.g, colors.dark_grey.b, colors.dark_grey.a)


	wireless_essid = conky_parse("${wireless_essid wlp82s0}")
	cairo_move_to(cr, 523, 732)
	cairo_show_text(cr, wireless_essid)
	cairo_stroke(cr)

	upspeed = conky_parse("${upspeed wlp82s0}") .. " Up"
	cairo_move_to(cr, 523, 744)
	cairo_show_text(cr, upspeed)
	cairo_stroke(cr)

	downspeed = conky_parse("${downspeed wlp82s0}") .. " Down"
	cairo_move_to(cr, 523, 756)
	cairo_show_text(cr, downspeed)
	cairo_stroke(cr)
end

function upspeed_gaugue(cr, epicenter)
	gaugue_props = {
		gaugue_value = conky_parse("${upspeedf wlp82s0}"),
		gaugue_max = 51200, -- this is 50MiB. Use this on wifi
		colors = {
			free_color = colors.dark_grey,
			used_color = colors.light_grey,
			rule_color = colors.lighter_grey
		},
		meter = {
			x = epicenter.x, -- the center x offset relative to conf top left
			y = epicenter.y, -- the center y offset relative to conf top left
			r = 40,  -- the radius of the guage
			w = 4    -- the width of the stroke
		},
		rule = {
			w = 3,
			l = 285
		}
	}

	ring_gaugue(cr, gaugue_props)
end

function downspeed_gaugue(cr, epicenter)
	gaugue_props = {
		gaugue_value = conky_parse("${downspeedf wlp82s0}"),
		-- gaugue_max = 512000, -- this is 500MiB in KiB use this if im on ethernet
		gaugue_max = 51200, -- this is 50MiB. Use this on wifi
		colors = {
			free_color = colors.dark_grey,
			used_color = colors.light_grey,
			rule_color = colors.lighter_grey
		},
		meter = {
			x = epicenter.x, -- the center x offset relative to conf top left
			y = epicenter.y, -- the center y offset relative to conf top left
			r = 32,  -- the radius of the guage
			w = 8    -- the width of the stroke
		}
	}

	ring_gaugue(cr, gaugue_props)
end

function filesystem_gaugues(cr)
	-- these are coenctric rings, so the centroid must be the same between all of them.
	epicenter = {
		x = 350,
		y = 950
	}
	root_fs_gaugue(cr, epicenter)
	home_fs_gaugue(cr, epicenter)
	part_2_gaugue(cr, epicenter) -- partition 2 contains root + home
	disk_table(cr)
end

function root_fs_gaugue(cr, epicenter)
	gaugue_props = {
		gaugue_name = "/root",
		gaugue_value = conky_parse("${fs_used_perc /root}"),
		gaugue_max = 100,
		colors = {
			free_color = colors.dark_grey,
			used_color = colors.light_grey,
		},
		meter = {
			x = epicenter.x, -- the center x offset relative to conf top left
			y = epicenter.y, -- the center y offset relative to conf top left
			r = 35,  -- the radius of the guage
			w = 4    -- the width of the stroke
		}
	}

	ring_gaugue(cr, gaugue_props)
end

function home_fs_gaugue(cr, epicenter)
	gaugue_props = {
		gaugue_name = "/home",
		gaugue_value = conky_parse("${fs_used_perc /home}"),
		gaugue_max = 100,
		colors = {
			free_color = colors.dark_grey,
			used_color = colors.light_grey,
		},
		meter = {
			x = epicenter.x, -- the center x offset relative to conf top left
			y = epicenter.y, -- the center y offset relative to conf top left
			r = 45,  -- the radius of the guage
			w = 10    -- the width of the stroke
		}
	}

	ring_gaugue(cr, gaugue_props)
end

function part_2_gaugue(cr, epicenter)
	partition_2_used_perc = math.floor(conky_parse("${fs_used_perc /home}") + conky_parse("${fs_used_perc /root}"))
	gaugue_props = {
		gaugue_name = "/nvme0n1p2",
		gaugue_value = partition_2_used_perc,
		gaugue_max = 100,
		colors = {
			free_color = colors.dark_grey,
			used_color = colors.light_grey,
			rule_color = colors.lighter_grey
		},
		meter = {
			x = epicenter.x, -- the center x offset relative to conf top left
			y = epicenter.y, -- the center y offset relative to conf top left
			r = 55,  -- the radius of the guage
			w = 4    -- the width of the stroke
		},
		rule = {
			w = 3,
			l = 365
		},
		annotation = {
			gaugue_name = "disk",
			unit = "%",
			value_font = value_font,
			default_font = default_font,
			font_size_large = 24,
			font_size_small = 12,
			value_loc = {
				x = 425,
				y = 895,
			},
			desc_loc = {
				x = 482,
				y = 895,
			},
			text_loc = {
				hr_len = 255,
				x = 425,
				y = 898,
			},
			accent_color = colors.lighter_grey,
			muted_color = colors.lighter_grey
		}
	}

	ring_gaugue(cr, gaugue_props)
	draw_rule(cr, gaugue_props)
	write_annotation(cr, gaugue_props)
end

function disk_table(cr)
	font_slant = CAIRO_FONT_SLANT_NORMAL
	font_face = CAIRO_FONT_WEIGHT_NORMAL
	cairo_select_font_face(cr, default_font, font_slant, font_face)
	cairo_set_font_size(cr, 12)
	cairo_set_source_rgba(cr, colors.dark_grey.r, colors.dark_grey.g, colors.dark_grey.b, colors.dark_grey.a)

	home_usage = "/root       " .. conky_parse("${fs_used /root}") .. " / " .. conky_parse("${fs_size /root}")
	cairo_move_to(cr, 425, 915)
	cairo_show_text(cr, home_usage)
	cairo_stroke(cr)

	home_usage = "/home       " .. conky_parse("${fs_used /home}") .. " / " .. conky_parse("${fs_size /home}")
	cairo_move_to(cr, 425, 927)
	cairo_show_text(cr, home_usage)
	cairo_stroke(cr)
end

function ring_gaugue(cr, gaugue_props)
	-- draws a ring gaugue
	-- cr: cairo created surface
	-- gaugue_props: table containing colors (free and used), a meter table, and gaugue metadata
	-- draw_rule: boolean to tell whether to draw a rule connecting the ring to the oriented edge of the cairo space

	if(gaugue_props.rule ~= nil) then
		draw_rule(cr, gaugue_props)
	end
	draw_free_ring(cr, gaugue_props)
	draw_used_ring(cr, gaugue_props)
end

function draw_rule(cr, gaugue_props)
	-- draws a rule from the top middle of the circle to the edge of the cairo space the gaugue is oriented to
	-- gaugue_props: the gaugue table containing the rule table

	-- find top center of ring and connect the rule to it at a 45 degree angle (its not really a 45 degree angle. I dont feel like calculating that atm)
	tangent_x = gaugue_props.meter.x
	tangent_y = gaugue_props.meter.y - gaugue_props.meter.r - (gaugue_props.meter.w / 2)
	end_x, end_y = tangent_x + 25, tangent_y - 25
	cairo_set_source_rgba(cr, gaugue_props.colors.rule_color.r, gaugue_props.colors.rule_color.g, gaugue_props.colors.rule_color.b, gaugue_props.colors.rule_color.a)
	cairo_set_line_width(cr, gaugue_props.rule.w)
	cairo_set_line_cap(cr, CAIRO_LINE_CAP_SQUARE)
	cairo_move_to(cr, tangent_x - 1, tangent_y + 1)
	cairo_line_to(cr, end_x, end_y)
	cairo_stroke(cr)

	-- find the end coordinate of the connector rule and draw another rule connecting it to the edge of the screen (note this value is estimated as there is no way (i know of) to get the size of the cairo space
	cairo_move_to(cr, end_x, end_y)
	cairo_line_to(cr, end_x + gaugue_props.rule.l, end_y)
	cairo_stroke(cr)
end

function draw_free_ring(cr, ring_props)
	-- draws a dark gray ring
	-- cr: cairo created surface
	-- ring_props: table containing colors (free and used), a meter table, and gaugue metadata

	start_angle, end_angle = 0, (2 * math.pi)
	cairo_set_source_rgba(cr, ring_props.colors.free_color.r, ring_props.colors.free_color.g, ring_props.colors.free_color.b, ring_props.colors.free_color.a)
	cairo_set_line_width(cr, ring_props.meter.w)
	cairo_set_line_cap(cr, CAIRO_LINE_CAP_BUTT)
	cairo_arc(cr, ring_props.meter.x, ring_props.meter.y, ring_props.meter.r, start_angle, end_angle)
	cairo_stroke(cr)
end

function draw_used_ring(cr, ring_props)
	-- draws a light circle indicating amount of resource used
	-- cr: cairo created surface
	-- ring_props: table containing colors (free and used), a meter table, and gaugue metadata

	-- move arc_indicator
	end_angle = ring_props.gaugue_value * (360 / ring_props.gaugue_max)

	cairo_set_source_rgba(cr, ring_props.colors.used_color.r, ring_props.colors.used_color.g, ring_props.colors.used_color.b, ring_props.colors.used_color.a)
	cairo_set_line_width(cr, ring_props.meter.w)
	-- angles in cairo are drawn from pi (90 deg) they must be offset to start from top
	cairo_arc(cr, ring_props.meter.x, ring_props.meter.y, ring_props.meter.r, degrees_to_radians(-90), degrees_to_radians(end_angle - 90))
	cairo_set_line_cap(cr, CAIRO_LINE_CAP_BUTT)
	cairo_stroke(cr)
end

function write_annotation(cr, gaugue_props)
	write_annotation_value(cr, gaugue_props)
	write_annotation_desc(cr, gaugue_props)
	draw_annotation_rule(cr, gaugue_props)
end

function write_annotation_value(cr, gaugue_props)
	text = gaugue_props.gaugue_value .. gaugue_props.annotation.unit
	font_slant = CAIRO_FONT_SLANT_NORMAL
	font_face = CAIRO_FONT_WEIGHT_NORMAL

	cairo_select_font_face(cr, gaugue_props.annotation.value_font, font_slant, font_face)
	cairo_set_font_size(cr, gaugue_props.annotation.font_size_large)
	cairo_set_source_rgba(cr, gaugue_props.annotation.accent_color.r, gaugue_props.annotation.accent_color.g, gaugue_props.annotation.accent_color.b, gaugue_props.annotation.accent_color.a)
	cairo_move_to(cr, gaugue_props.annotation.value_loc.x, gaugue_props.annotation.value_loc.y)
	cairo_show_text(cr, text)
	cairo_stroke(cr)
end

function write_annotation_desc(cr, gaugue_props)
	text = gaugue_props.annotation.gaugue_name
	font_slant = CAIRO_FONT_SLANT_NORMAL
	font_face = CAIRO_FONT_WEIGHT_NORMAL

	cairo_select_font_face(cr, gaugue_props.annotation.default_font, font_slant, font_face)
	cairo_set_font_size(cr, gaugue_props.annotation.font_size_small)
	cairo_set_source_rgba(cr, gaugue_props.annotation.muted_color.r, gaugue_props.annotation.muted_color.g, gaugue_props.annotation.muted_color.b, gaugue_props.annotation.muted_color.a)
	cairo_move_to(cr, gaugue_props.annotation.desc_loc.x, gaugue_props.annotation.desc_loc.y)
	cairo_show_text(cr, text)
	cairo_stroke(cr)
end

function draw_annotation_rule(cr, gaugue_props)
	-- draw the rule
	cairo_set_source_rgba(cr, gaugue_props.annotation.muted_color.r, gaugue_props.annotation.muted_color.g, gaugue_props.annotation.muted_color.b, gaugue_props.annotation.muted_color.a)
	cairo_set_line_width(cr, 1)
	cairo_set_line_cap(cr, CAIRO_LINE_CAP_BUTT)
	cairo_move_to(cr, gaugue_props.annotation.text_loc.x, gaugue_props.annotation.text_loc.y)
	cairo_line_to(cr, gaugue_props.annotation.text_loc.x + gaugue_props.annotation.text_loc.hr_len, gaugue_props.annotation.text_loc.y)
	cairo_stroke(cr)
end

function degrees_to_radians(degrees)
	return degrees * (math.pi / 180)
end
