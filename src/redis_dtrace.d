provider redis {
    probe get__entry(char *key);

    probe get__return(char *key, int ret_val);
};