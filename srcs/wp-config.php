<?php
/**
 * Основные параметры WordPress.
 */

// ** Параметры MySQL:
define( 'DB_NAME', 'wp' );
define( 'DB_USER', 'adm' );
define( 'DB_PASSWORD', 'adm' );
define( 'DB_HOST', 'localhost' );
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );

/**#@+
 * Уникальные ключи и соли для аутентификации.
 */
define( 'AUTH_KEY',         'впишите сюда уникальную фразу' );
define( 'SECURE_AUTH_KEY',  'впишите сюда уникальную фразу' );
define( 'LOGGED_IN_KEY',    'впишите сюда уникальную фразу' );
define( 'NONCE_KEY',        'впишите сюда уникальную фразу' );
define( 'AUTH_SALT',        'впишите сюда уникальную фразу' );
define( 'SECURE_AUTH_SALT', 'впишите сюда уникальную фразу' );
define( 'LOGGED_IN_SALT',   'впишите сюда уникальную фразу' );
define( 'NONCE_SALT',       'впишите сюда уникальную фразу' );

/**#@-*/

/**
 * Префикс таблиц в базе данных WordPress.
 */
$table_prefix = 'wp_';

/**
 * Режим отладки WordPress.
 *
 * Измените это значение на true, чтобы включить отображение уведомлений при разработке.
 */
define( 'WP_DEBUG', false );

/** Абсолютный путь к директории WordPress. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Инициализирует переменные WordPress и подключает файлы. */
require_once ABSPATH . 'wp-settings.php';