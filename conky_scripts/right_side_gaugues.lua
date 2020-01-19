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

	battery_gaugue(cr)
	cpu_gaugue(cr)
	filesystem_gaugues(cr)
	brightness_gaugue(cr)

    cairo_destroy(cr)
    cairo_surface_destroy(cs)
    cr = nil
end

function battery_gaugue(cr)
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
			x = 350, -- the center x offset relative to conf top left
			y = 400, -- the center y offset relative to conf top left
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
				x = 482,
				y = 353,
			},
			text_loc = {
				hr_len = 255,
				x = 425,
				y = 356,
			},
			add_text = {},
			accent_color = colors.lighter_grey,
			muted_color = colors.lighter_grey
		}
	}

	write_annotation(cr, gaugue_props)
	ring_gaugue(cr, gaugue_props)
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
			x = 450, -- the center x offset relative to conf top left
			y = 575, -- the center y offset relative to conf top left
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
			add_text = {},
			accent_color = colors.lighter_grey,
			muted_color = colors.lighter_grey
		}
	}

	write_annotation(cr, gaugue_props)
	ring_gaugue(cr, gaugue_props)
end


function brightness_gaugue(cr)
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
			x = 450, -- the center x offset relative to conf top left
			y = 750, -- the center y offset relative to conf top left
			r = 40,  -- the radius of the guage
			w = 4    -- the width of the stroke
		},
		rule = {
			w = 3,
			l = 285
		},
		annotation = {
			gaugue_name = "Bright",
			unit = "%",
			value_font = value_font,
			default_font = default_font,
			font_size_large = 24,
			font_size_small = 12,
			value_loc = {
				x = 523,
				y = 712,
			},
			desc_loc = {
				x = 570,
				y = 712,
			},
			text_loc = {
				hr_len = 160,
				x = 523,
				y = 715,
			},
			add_text = {},
			accent_color = colors.lighter_grey,
			muted_color = colors.lighter_grey
		}
	}

	write_annotation(cr, gaugue_props)
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
	part_2_gaugue(cr, epicenter) -- partition 2 contains root + home + swap
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
			add_text = {},
			accent_color = colors.lighter_grey,
			muted_color = colors.lighter_grey
		}
	}

	ring_gaugue(cr, gaugue_props)
	draw_rule(cr, gaugue_props)
	write_annotation(cr, gaugue_props)
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
	write_annotation_text(cr, gaugue_props)
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

function write_annotation_text(cr, gaugue_props)
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
