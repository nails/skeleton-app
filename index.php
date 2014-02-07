<?php

/*
 *---------------------------------------------------------------
 * NAILS MAIN APPLICATION
 *---------------------------------------------------------------
 *
 * This is the kick off point for the main Nails Application.
 *
 * Lead Developer: Pablo de la Peña	(p@shedcollective.org, @hellopablo)
 * Lead Developer: Gary Duncan		(g@shedcollective.org, @gsdd)
 *
 * Documentation: http://docs.nailsapp.co.uk
 *
 * CodeIgniter version: v2.1.0
 *
 *
 *---------------------------------------------------------------
 * APP SETTINGS
 *---------------------------------------------------------------
 *
 * Load app specific settings.
 *
 */

 	if ( ! file_exists( dirname(__FILE__) . '/settings/app.php' ) ) :

 		if ( isset( $_SERVER['SCRIPT_NAME'] ) ) :

 			$_location  = dirname( $_SERVER['SCRIPT_NAME'] );
 			$_location .= substr( $_location, -1 ) != '/' ? '/' : '';

	 		header( 'Location: ' . $_location . 'nails-install.php' );
		 	exit( 0 );

 		else :

			echo '<style type="text/css">';
			echo 'p {font-family:monospace;margin:20px 10px;}';
			echo 'strong { color:red;}';
			echo 'code { padding:5px;border:1px solid #CCC;background:#EEE }';
			echo '</style>';
			echo '<p><strong>ERROR:</strong> Missing settings/app.php; please run installer.</p>';
			exit( 0 );

 		endif;

	endif;

 	require dirname(__FILE__) . '/settings/app.php';


/*
 *---------------------------------------------------------------
 * DEPLOY SETTINGS
 *---------------------------------------------------------------
 *
 * Load environment specific settings.
 *
 */
 	if ( ! file_exists( dirname(__FILE__) . '/settings/deploy.php' ) ) :

 		if ( isset( $_SERVER['SCRIPT_NAME'] ) ) :

 			$_location  = dirname( $_SERVER['SCRIPT_NAME'] );
 			$_location .= substr( $_location, -1 ) != '/' ? '/' : '';

	 		header( 'Location: ' . $_location . 'nails-install.php' );
		 	exit( 0 );

 		else :

			echo '<style type="text/css">';
			echo 'p {font-family:monospace;margin:20px 10px;}';
			echo 'strong { color:red;}';
			echo 'code { padding:5px;border:1px solid #CCC;background:#EEE }';
			echo '</style>';
			echo '<p><strong>ERROR:</strong> Missing settings/deploy.php; please run installer.</p>';
			exit( 0 );

 		endif;

	endif;

 	require dirname(__FILE__) . '/settings/deploy.php';


/*
 *---------------------------------------------------------------
 * GLOBAL CONSTANTS
 *---------------------------------------------------------------
 *
 * These global constants need defined early on, unless specified already
 * defined in app.php or deploy.php define the defaults.
 *
 */

	if ( ! defined( 'NAILS_PATH' ) ) :

		define( 'NAILS_PATH', realpath( dirname( __FILE__ ) . '/vendor/shed/nails/' ) . '/' );

	endif;


/*
 *---------------------------------------------------------------
 * TEST NAILS AVAILABILITY
 *---------------------------------------------------------------
 *
 * Load environment specific settings.
 *
 */
 	if ( ! file_exists( NAILS_PATH . 'core/CORE_NAILS_Controller.php' ) ) :

		echo '<style type="text/css">';
		echo 'p {font-family:monospace;margin:20px 10px;}';
		echo 'strong { color:red;}';
		echo 'code { padding:5px;border:1px solid #CCC;background:#EEE }';
		echo '</style>';
		echo '<p><strong>ERROR:</strong> Cannot find a valid Nails installation, have you run <code>composer update</code>?.</p>';
		exit( 0 );

	endif;


/*
 *---------------------------------------------------------------
 * LOAD NAILS COMMON FUNCTIONS
 *---------------------------------------------------------------
 *
 * Loads functions defined by Nails which may be required prior to the
 * Nails Bootstrap initiating.
 *
 */
 	if ( ! file_exists( NAILS_PATH . 'core/CORE_NAILS_Common.php' ) ) :

 		//	Use the NAils startup error template, as we've established
 		//	Nails is available

		$_ERROR = 'Could not find <code>CORE_NAILS_Common.php</code>, ensure that your NAils set up is correct.';
		include NAILS_PATH . 'errors/startup_error.php';

	endif;

	require_once NAILS_PATH . 'core/CORE_NAILS_Common.php';

/*
 *---------------------------------------------------------------
 * CODEIGNITER
 *---------------------------------------------------------------
 *
 * Nails configurations complete, kick-start CodeIgniter. Everything
 * below this line is vanilla CodeIgniter.
 *
 */

/*
 *---------------------------------------------------------------
 * SYSTEM FOLDER NAME
 *---------------------------------------------------------------
 *
 * This variable must contain the name of your "system" folder.
 * Include the path if the folder is not in the same  directory
 * as this file.
 *
 */
	$system_path = NAILS_PATH . 'CodeIgniter/system';

/*
 *---------------------------------------------------------------
 * APPLICATION FOLDER NAME
 *---------------------------------------------------------------
 *
 * If you want this front controller to use a different "application"
 * folder then the default one you can set its name here. The folder
 * can also be renamed or relocated anywhere on your server.  If
 * you do, use a full server path. For more info please see the user guide:
 * http://codeigniter.com/user_guide/general/managing_apps.html
 *
 * NO TRAILING SLASH!
 *
 */
	$application_folder = 'application';

/*
 *---------------------------------------------------------------
 * DEFAULT CONTROLLER
 *---------------------------------------------------------------
 *
 * Normally you will set your default controller in the routes.php file.
 * You can, however, force a custom routing by hard-coding a
 * specific controller class/function here.  For most applications, you
 * WILL NOT set your routing here, but it's an option for those
 * special instances where you might want to override the standard
 * routing in a specific front controller that shares a common CI installation.
 *
 * IMPORTANT:  If you set the routing here, NO OTHER controller will be
 * callable. In essence, this preference limits your application to ONE
 * specific controller.  Leave the function name blank if you need
 * to call functions dynamically via the URI.
 *
 * Un-comment the $routing array below to use this feature
 *
 */
	// The directory name, relative to the "controllers" folder.  Leave blank
	// if your controller is not in a sub-folder within the "controllers" folder
	// $routing['directory'] = '';

	// The controller class file name.  Example:  Mycontroller
	// $routing['controller'] = '';

	// The controller function you wish to be called.
	// $routing['function']	= '';


/*
 * -------------------------------------------------------------------
 *  CUSTOM CONFIG VALUES
 * -------------------------------------------------------------------
 *
 * The $assign_to_config array below will be passed dynamically to the
 * config class when initialized. This allows you to set custom config
 * items or override any default config values found in the config.php file.
 * This can be handy as it permits you to share one application between
 * multiple front controller files, with each file containing different
 * config values.
 *
 * Un-comment the $assign_to_config array below to use this feature
 *
 */
	// $assign_to_config['name_of_config_item'] = 'value of config item';



// --------------------------------------------------------------------
// END OF USER CONFIGURABLE SETTINGS.  DO NOT EDIT BELOW THIS LINE
// --------------------------------------------------------------------

/*
 * ---------------------------------------------------------------
 *  Resolve the system path for increased reliability
 * ---------------------------------------------------------------
 */

	// Set the current directory correctly for CLI requests
	if (defined('STDIN'))
	{
		chdir(dirname(__FILE__));
	}

	if (realpath($system_path) !== FALSE)
	{
		$system_path = realpath($system_path).'/';
	}

	// ensure there's a trailing slash
	$system_path = rtrim($system_path, '/').'/';

	// Is the system path correct?
	if ( ! is_dir($system_path))
	{
		exit("Your system folder path does not appear to be set correctly. Please open the following file and correct this: ".pathinfo(__FILE__, PATHINFO_BASENAME));
	}

/*
 * -------------------------------------------------------------------
 *  Now that we know the path, set the main path constants
 * -------------------------------------------------------------------
 */
	// The name of THIS file
	define('SELF', pathinfo(__FILE__, PATHINFO_BASENAME));

	// The PHP file extension
	// this global constant is deprecated.
	define('EXT', '.php');

	// Path to the system folder
	define('BASEPATH', str_replace("\\", "/", $system_path));

	// Path to the front controller (this file)
	define('FCPATH', str_replace(SELF, '', __FILE__));

	// Name of the "system folder"
	define('SYSDIR', trim(strrchr(trim(BASEPATH, '/'), '/'), '/'));


	// The path to the "application" folder
	if (is_dir($application_folder))
	{
		define('APPPATH', $application_folder.'/');
	}
	else
	{
		if ( ! is_dir(BASEPATH.$application_folder.'/'))
		{
			exit("Your application folder path does not appear to be set correctly. Please open the following file and correct this: ".SELF);
		}

		define('APPPATH', BASEPATH.$application_folder.'/');
	}

/*
 *---------------------------------------------------------------
 * LOAD THE BOOTSTRAP FILE
 *---------------------------------------------------------------
 *
 * And away we go...
 *
 */
require_once BASEPATH.'core/CodeIgniter.php';

/* End of file index.php */
/* Location: ./index.php */