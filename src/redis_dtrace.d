provider redis {
    probe command__entry(char *cmd);

    probe command__return(char *cmd);
};