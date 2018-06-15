#include <stdint.h>
#include <stdbool.h>

/*
 * given a list of directories, seperated by a colon (e.g $PATH)
 * and a fileName.  Return the exanded path to the fiel in the first found.
 */
int expandPath(char *dirList, char *fileName, char *buffer);

void memDump(uint8_t *address, int length);

/**
 * @name athQkey
 * @brief return a flag indictaing if a key has been pressed.
 * @return boolean false if no key present, true if otherwise.
 * 
 */ 
bool athQkey() ;
/**
 * @name athGetKey
 * @brief Wait until a key is pressed an then return with the value immediately.
 * @return chat Key value.
 * 
 */
char athGetKey() ;
/**
 * @name fatal
 * @brief Display a message and exit with a non-zero code
 * @param[in] message Pointer to message.
 * @return void
 * 
 */
void fatal(char *message) ;
char keystroke(int t) ;

/**
 * @name strToBool
 * @brief Convert YES, ON, or TRUE to non-zero,or true, anything else 0, or false.
 * @param[in] message Pointer to string.
 * @return bool
 */
bool strToBool( char *msg );
/**
 * @name strCat
 * @brief Join two forth strings together.
 * @param[in] head Pointer to string.
 * @param[in] hLen string length.
 * @param[in] tail Pointer to string to append.
 * @param[in] tLen string length.
 * @return Total length
 */
uint32_t strCat( char *head, uint32_t hLen, char *tail, uint32_t tLen);
