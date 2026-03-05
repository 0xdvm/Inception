<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the website, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://developer.wordpress.org/advanced-administration/wordpress/wp-config/
 *
 * @package WordPress
 */

define('DB_NAME', getenv('MYSQL_DATABASE'));
define('DB_USER', getenv('MYSQL_USER'));

$dbPassFile = getenv('MYSQL_PASSWORD_FILE');

if ($dbPassFile && file_exists($dbPassFile)) {
    $dbPassword = trim(file_get_contents($dbPassFile));
} else {
    $dbPassword = getenv('MYSQL_PASSWORD');
}

define('DB_PASSWORD', $dbPassword);
define('DB_HOST', getenv('DB_HOST') ?: 'localhost');

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8mb4' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */

define('AUTH_KEY',         'b-*y v!?8?NDxYV~<w]7DR%43.1$kE)AQkG]#-=|7te4}k8_gkN-~pl+_(lP%zRi');
define('SECURE_AUTH_KEY',  '=yfw0B-/l[~{.-WHky*bml1wg295h!Rm<M--SC`>}4.lWzOWbJ.{f{cM<pm0xQy{');
define('LOGGED_IN_KEY',    'eF)oZ@%4+;%r+GI/y&+`ZyHq|@AkP]hGX*W^]G`yZx$a`5-()QWfsiT[#BX?F[G5');
define('NONCE_KEY',        ':T^D@kQLfP%X#!G|.*qP=@H;7q=Sc|i.AY+8i!n:zS-T;5U3<vGCJ_;~}!!;dPKN');
define('AUTH_SALT',        '9L_yv9{#!G|<&TXPrRSf!]Q,nNI-9}BL*@K`t`CUsiN 10>h~w6.1H 7y;AcGJrU');
define('SECURE_AUTH_SALT', 'WkfnJ`,u.0s-E1fD](38l&Cabq*cmDE]AKf32_L<FqcD>b+lu}(C^&G1lC+w`sE{');
define('LOGGED_IN_SALT',   'd9E6Y(u5f-hQ4<gh{AKIFm7/W~-:X8`>hb+JBkJ5~>-96mfm&BH,k? #fUx$$X<J');
define('NONCE_SALT',       '<pWC?*xZZ]dAY85Jc y9F|}AFlVFWlF8-+eAC[+5X(B(a+,Xlr(l+Ik?`im#HJ}v');

/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 *
 * At the installation time, database tables are created with the specified prefix.
 * Changing this value after WordPress is installed will make your site think
 * it has not been installed.
 *
 * @link https://developer.wordpress.org/advanced-administration/wordpress/wp-config/#table-prefix
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://developer.wordpress.org/advanced-administration/debug/debug-wordpress/
 */
define( 'WP_DEBUG', false );

/* Add any custom values between this line and the "stop editing" line. */



/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';