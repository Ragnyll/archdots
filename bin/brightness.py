#!/bin/python
import fire
from os import path
from sys import exit

INTEL_BRIGHTNESS_DIR = path.abspath('/sys/class/backlight/intel_backlight/')
INTEL_MAX_BRIGHTNESS_FILE = path.join(INTEL_BRIGHTNESS_DIR, 'max_brightness')
INTEL_CURRENT_BRIGHTNESS_FILE = path.join(INTEL_BRIGHTNESS_DIR, 'brightness')


class BrightnessManager(object):
    """BrightnessManager
        various functions around managing the brightness on my laptop
    """
    def __init__(self, graphics_driver_type='intel', brightness_step_percent=5):
        """changes the brightness files being configured based upon the current graphics card

        :param graphics_driver_type: the
        """
        self.brightness_step_percent = brightness_step_percent
        if graphics_driver_type == 'intel':
            self.max_brightness_file = INTEL_MAX_BRIGHTNESS_FILE
            self.current_brightness_file = INTEL_CURRENT_BRIGHTNESS_FILE
        elif graphics_driver_type == 'nvidia':
            print('brightness manager not setup for nvidia card yet')
            exit(1)
        else:
            print('brightness manager is not set up for ' + graphics_driver_type)
            exit(1)

    def status(self):
        """Prints status about the current brightness configuration
        """
        with open(self.max_brightness_file, 'r') as max_brightness_file:
            max_brightness = int(max_brightness_file.readline())

        with open(self.current_brightness_file, 'r') as current_brightness_file:
            current_brightness = int(current_brightness_file.readline())

        print('Current brightness is at ' + str((current_brightness / max_brightness) * 100) + '%')

    def increase_brightness():
        pass

    def decrease_brightness():
        pass

    def set_brightness():
        pass


def main():
    brightness_manager = BrightnessManager()

    fire.Fire(brightness_manager)


if __name__ == '__main__':
    main()
